//
//  TeamListView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct TeamListView: View {
    @EnvironmentObject var teamDataVM : TeamDataViewModel
    @Binding var hasSubmittedMatches : Bool
    var teams : [TeamData]  {
        if !hasSubmittedMatches {
            return teamDataVM.teams
        } else {
            return teamDataVM.winningTeams
        }
    }
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(columns: [GridItem].init(repeating: GridItem(.flexible()), count: 2)) {
                ForEach(teams, id: \.id) {team in
                    TeamListCardView(teamData: team)
                        .background(Color.systemBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                }
            }
            .padding()
            .background(Color.background)
        }
    }
    
}

struct TeamListView_Previews: PreviewProvider {
    static var teamDataVM : TeamDataViewModel = {
        let teamDataVM = TeamDataViewModel()
        teamDataVM.textToTeamsDataParser(testCase01Teams)
        do { try teamDataVM.playMatches(matchInputText: testCase01Matches) }
        catch  { fatalError("Error loading testCases Matches") }
        return teamDataVM
    }()
    static var previews: some View {
        TeamListView(hasSubmittedMatches: .constant(false))
            .environmentObject(teamDataVM)
            .previewLayout(.sizeThatFits)
    }
}
