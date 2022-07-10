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
    
    private func giveMatchPoint(yourScore: Int, theirScore: Int) -> Int {
        if yourScore > theirScore { return 3 }
        else if yourScore < theirScore { return 0 }
        else { return 1 }
    }
    
    func playMatches(matchInputText input: String) throws {
        let allMatches = try textToMatchDataParser(input)
        for matchData in allMatches {
            let teamA = Array(matchData)[0].key, teamB = Array(matchData)[1].key
            let teamAScore = Array(matchData)[0].value, teamBScore = Array(matchData)[1].value
            if let teamAData = self.teams.first(where: {$0.name == teamA}) {
                teamAData.goalsScored += teamAScore
                teamAData.matchPoints += giveMatchPoint(yourScore: teamAScore, theirScore: teamBScore)
            }
            if let teamBData = self.teams.first(where: {$0.name == teamB}) {
                teamBData.goalsScored += teamBScore
                teamBData.matchPoints += giveMatchPoint(yourScore: teamBScore, theirScore: teamAScore)
            }
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
