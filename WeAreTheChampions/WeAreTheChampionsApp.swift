//
//  WeAreTheChampionsApp.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

@main
struct WeAreTheChampionsApp: App {
    @StateObject var teamDataVM = TeamDataViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(teamDataVM)
        }
    }
}
