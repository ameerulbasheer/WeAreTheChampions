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
        // Give matchPoints first
        for team in self.teams {
            team.matchPoints = giveMatchPoints(to: team, isAlternate: false)
        }
        // Find top 4 teams for each group
        self.winningTeams = findWinningTeams(for: 1)
        self.winningTeams += findWinningTeams(for: 2)
    }
    
    // MARK: - Find Qualifying teams Section
    @Published var winningTeams = [TeamData]()
    
    private func findWinningTeams(for group: Int) -> [TeamData] {
        var currGroup = teams.filter({$0.group == group})
        var winningTeamsInCurrGroup = [TeamData]()
        while winningTeamsInCurrGroup.count < 4 {
            findHighestMPTeams(teams: &currGroup, winningTeams: &winningTeamsInCurrGroup)
        }
        return winningTeamsInCurrGroup
    }
    
    private func assignWinner(tiedTeams: [TeamData], teams: inout [TeamData], winningTeams: inout [TeamData]) {
        for team in tiedTeams {
            winningTeams.append(team)
            teams = teams.filter({$0.name != team.name})
        }
    }
    
    private func findHighestMPTeams(teams: inout [TeamData], winningTeams: inout [TeamData]) {
        if let highestAltMP = teams.max(by: {$0.matchPoints < $1.matchPoints})?.matchPoints {
            let highestAltMPTeams = teams.filter({$0.matchPoints == highestAltMP})
            if highestAltMPTeams.count <= (4 - winningTeams.count) {
                assignWinner(tiedTeams: highestAltMPTeams, teams: &teams, winningTeams: &winningTeams)
            } else {
                // MARK: Second-level matching and so-on
                findHighestGS(tiedTeams: highestAltMPTeams, teams: &teams, winningTeams: &winningTeams)
            }
        }
    }
    
    private func findHighestGS(tiedTeams: [TeamData], teams: inout [TeamData], winningTeams: inout [TeamData]) {
        if let highestGS = tiedTeams.max(by: {$0.goalsScored < $1.goalsScored})?.goalsScored {
            let highestGSTeams = tiedTeams.filter({$0.goalsScored == highestGS})
            if highestGSTeams.count <= (4 - winningTeams.count) {
                assignWinner(tiedTeams: highestGSTeams, teams: &teams, winningTeams: &winningTeams)
            } else {
                // MARK: Alternate MP
                findHighestAltMPTeams(tiedTeams: highestGSTeams, teams: &teams, winningTeams: &winningTeams)
            }
        }
    }
    
    private func findHighestAltMPTeams(tiedTeams: [TeamData], teams: inout [TeamData], winningTeams: inout [TeamData]) {
        // MARK: Give Alt scoring
        for team in tiedTeams {
            team.matchPoints = giveMatchPoints(to: team, isAlternate: true)
        }
        if let highestAltMP = tiedTeams.max(by: {$0.matchPoints < $1.matchPoints})?.matchPoints {
            let highestAltMPTeams = tiedTeams.filter({$0.matchPoints == highestAltMP})
            if highestAltMPTeams.count <= (4 - winningTeams.count) {
                assignWinner(tiedTeams: highestAltMPTeams, teams: &teams, winningTeams: &winningTeams)
            } else {
                // MARK: Earliest Teams
                findEarliestTeam(tiedTeams: highestAltMPTeams, teams: &teams, winningTeams: &winningTeams)
            }
        }
    }
    
    private func findEarliestTeam(tiedTeams: [TeamData], teams: inout [TeamData], winningTeams: inout [TeamData]) {
        if let earliestDate = tiedTeams.min(by: {$0.date > $1.date})?.date {
            let earliestTeams = tiedTeams.filter({$0.date == earliestDate})
            if earliestTeams.count <= (4 - winningTeams.count) {
                assignWinner(tiedTeams: earliestTeams, teams: &teams, winningTeams: &winningTeams)
            } else {
                // MARK: Get first 4 elements
                for team in earliestTeams.prefix(4) {
                    winningTeams.append(team)
                    teams = teams.filter({$0.name != team.name})
                }
            }
        }
    }
}
