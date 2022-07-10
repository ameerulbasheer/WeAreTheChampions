//
//  TeamDataViewModel.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation
import SwiftUI

enum SyntaxError : Error {
    case invalid
}

final class TeamDataViewModel : ObservableObject {
    @Published var teams = [TeamData]()
    @Published var hasMatched = false
    
    @Published var winningTeams = [TeamData]()
    
    func textToTeamsDataParser(_ input: String) {
        let teamDataStringArr = parseStringToData(input)
        teamDataStringArr.forEach { team in
            if let groupNumber = Int(team[2]) {
                self.teams.append(TeamData(name: team[0],
                                           group: groupNumber,
                                           dateString: team[1]))
            }
        }
    }
    
    func playMatches(matchInputText input: String) throws {
        let allMatches = try textToMatchDataParser(input)
        for matchData in allMatches {
            let teamA = Array(matchData)[0].key, teamB = Array(matchData)[1].key
            let teamAScore = Array(matchData)[0].value, teamBScore = Array(matchData)[1].value
            if let teamAData = self.teams.first(where: {$0.name == teamA}) {
                teamAData.goalsScored += teamAScore
                guard let result = teamAData.matchResults[giveMatchResult(yourScore: teamAScore, theirScore: teamBScore)] else {
                    fatalError("Error accessing match result!")
                }
                teamAData.matchResults[giveMatchResult(yourScore: teamAScore, theirScore: teamBScore)] = result + 1
            }
            if let teamBData = self.teams.first(where: {$0.name == teamB}) {
                teamBData.goalsScored += teamBScore
                guard let result = teamBData.matchResults[giveMatchResult(yourScore: teamBScore, theirScore: teamAScore)] else {
                    fatalError("Error accessing match result!")
                }
                teamBData.matchResults[giveMatchResult(yourScore: teamBScore, theirScore: teamAScore)] = result + 1
            }
        }
//        Give matchPoints first
        for team in self.teams {
            team.matchPoints = giveMatchPoints(to: team, isAlternate: false)
        }
//        Find top 4 teams for each group
        self.winningTeams = findWinningTeams(for: 1)
        self.winningTeams += findWinningTeams(for: 2)
    }
    
    func findWinningTeams(for groupNumber: Int) -> [TeamData] {
        let highestTeams = self.teams
            .filter({$0.group == groupNumber})
            .filter({$0.matchPoints >= findLowestWinningMP(for: groupNumber)})
            .sorted(by: {$0.matchPoints > $1.matchPoints})
        if highestTeams.count == 4 {
            return highestTeams
        } else {
            var highestTeamsArr = [[TeamData]].init(repeating: [], count: 4)
            guard var currHighestMatchPoints = highestTeams.first?.matchPoints else {fatalError("Error accessing matchPoints!")}
            var i = 0
            // Get the arrays of tied teams
            for team in highestTeams {
                if team.matchPoints == currHighestMatchPoints {
                    highestTeamsArr[i].append(team)
                } else if team.matchPoints < currHighestMatchPoints {
                    highestTeamsArr[i+1].append(team)
                    currHighestMatchPoints = team.matchPoints
                    i += 1
                }
            }
            // MARK: Get only winning tied teams
            for (index, teams) in highestTeamsArr.enumerated() where teams.count > 1 {
                let winningTiedTeam = findHighestGoalsScored(from: teams)
//                teams = []
//                teams.append(winningTiedTeam)
                highestTeamsArr[index] = [winningTiedTeam]
            }
            
            var winningTeams = [TeamData]()
            highestTeamsArr.forEach { team in
                winningTeams.append(contentsOf: team)
            }
            return winningTeams
        }
    }
    
    private func findLowestWinningMP(for groupNumber: Int) -> Int {
        let sortedTeams = self.teams.filter({$0.group == groupNumber}).sorted(by: {$0.matchPoints > $1.matchPoints})
        guard var fourthHighestMP = sortedTeams.first?.matchPoints else {
            fatalError("No teams recorded!")
        }
        var i = 1
        var count = 1
        while count < 4 && i < sortedTeams.count {
            if sortedTeams[i].matchPoints < fourthHighestMP {
                fourthHighestMP = sortedTeams[i].matchPoints
                count += 1
            }
            i += 1
        }
        return fourthHighestMP
    }
    
    private func findHighestGoalsScored(from teams: [TeamData]) -> TeamData {
        guard let highestGoalsScored = teams.max(by: {$0.goalsScored > $1.goalsScored})?.goalsScored else {
            fatalError("Error gtting alternate goalsScored!")
        }
        let highestGSTeams = teams.filter({$0.goalsScored == highestGoalsScored})
        if highestGSTeams.count > 1 {
            return findAltHighestMPTeam(from: highestGSTeams)
        } else {
            return highestGSTeams.first!
        }
    }
    
    private func findAltHighestMPTeam(from teams: [TeamData]) -> TeamData {
        for team in teams {
            team.matchPoints = giveMatchPoints(to: team, isAlternate: true)
        }
        guard let altHighestMP = teams.max(by: {$0.matchPoints > $1.matchPoints})?.matchPoints else {
            fatalError("Error gtting alternate matchPoints!")
        }
        let altHighestMPTeams = teams.filter({$0.matchPoints == altHighestMP})
        if altHighestMPTeams.count > 1 {
            return findEarliestTeam(from: altHighestMPTeams)
        } else {
            return altHighestMPTeams.first!
        }
    }
    
    private func findEarliestTeam(from teams: [TeamData]) -> TeamData {
        guard let earliestTeam = teams.min(by: {$0.date < $1.date}) else {
            fatalError("Error getting earliest team!")
        }
        return earliestTeam
    }
    
    
    private func textToMatchDataParser(_ input: String) throws -> [[String : Int]] {
        //    Syntax: <Team A name> <Team B name> <Team A goals scored> <Team B goals scored>
        let dataStringArr = parseStringToData(input)
        var allMatches = [[String : Int]]()
        try dataStringArr.forEach { match in
            var matchData = [String : Int]()
            if let teamAScore = Int(match[2]), let teamBScore = Int(match[3]) {
                matchData[match[0]] = teamAScore
                matchData[match[1]] = teamBScore
            } else {
                throw SyntaxError.invalid
            }
            allMatches.append(matchData)
        }
        return allMatches
    }
    
    private func giveMatchResult(yourScore: Int, theirScore: Int) -> String {
        if yourScore > theirScore { return "win" }
        else if yourScore < theirScore { return "loss" }
        else { return "draw" }
    }
    
    private func giveMatchPoints(to team: TeamData, isAlternate: Bool) -> Int {
        guard let wins = team.matchResults["win"], let losses = team.matchResults["loss"], let draws = team.matchResults["draw"] else {
            fatalError("Error accessing match results!")
        }
        if !isAlternate {
            return wins * 3 + draws * 1 + losses * 0
        } else {
            return 0
        }
    }
    
    private func parseStringToData(_ input: String) -> [[String]] {
        let dataByLine: [String] = input.components(separatedBy: "\n")
        var dataByColumn = [[String]]()
        for line in dataByLine {
            dataByColumn.append(line.components(separatedBy: " "))
        }
        return dataByColumn
    }
}
