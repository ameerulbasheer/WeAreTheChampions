//
//  TeamDataModel.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation

struct TeamData {
    let id = UUID()
    var name : String
    var group : Int
    var date : Date
    var goalsScored : Int = 0
    var matchPoints : Int = 0
    
    init(name: String, group: Int, dateString: String ) {
        self.name = name
        self.group = group
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            self.date = Date()
        }
    }
}

func textToTeamsDataParser(_ input: String) -> [TeamData] {
    var teamDataStringArr = [[String]]()
    let teamsStringArr: [String] = input.components(separatedBy: "\n")
    for string in teamsStringArr {
        teamDataStringArr.append(string.components(separatedBy: " "))
    }
    var teamsData = [TeamData]()
    teamDataStringArr.forEach { team in
        if let groupNumber = Int(team[2]) {
            teamsData.append(TeamData(name: team[0],
                                      group: groupNumber,
                                      dateString: team[1]))
        }
    }
    return teamsData
}


