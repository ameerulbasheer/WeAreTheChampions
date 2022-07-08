//
//  TeamListView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct TeamListView: View {
    var teams : [TeamData]
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: [GridItem].init(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(teams, id: \.id) {team in
                    TeamListCardView(teamData: team)
                        .background(Color.systemBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                }
            }
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
        TeamListView(teams: teamDataVM.teams)
            .previewLayout(.sizeThatFits)
    }
}
