//
//  TeamDataModel.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation

class TeamData {
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
        dateFormatter.dateFormat = "MM/yy"
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            self.date = Date()
        }
    }
}
