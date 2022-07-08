//
//  TeamDataViewModel.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation

final class TeamDataViewModel : ObservableObject {
    @Published var teams = [TeamData]()
    
}
