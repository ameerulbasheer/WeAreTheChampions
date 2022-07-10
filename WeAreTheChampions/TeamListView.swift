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
        return teamDataVM.teams
    }
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(columns: [GridItem].init(repeating: GridItem(.flexible()), count: 2)) {
                ForEach(teams, id: \.id) {team in
                    TeamListCardView(teamData: team)
                        .environmentObject(teamDataVM)
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
        teamDataVM.teams = textToTeamsDataParser(testCase01Teams)
        return teamDataVM
    }()
    static var previews: some View {
        TeamListView(hasSubmittedMatches: .constant(true))
            .environmentObject(teamDataVM)
            .previewLayout(.sizeThatFits)
    }
}
