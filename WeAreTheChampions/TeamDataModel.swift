//
//  TeamDataModel.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation

class TeamData: ObservableObject {
    @Published var id = UUID()
    @Published var name : String
    @Published var group : Int
    @Published var date : Date
    @Published var goalsScored : Int = 0
    @Published var matchPoints : Int = 0
    
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
