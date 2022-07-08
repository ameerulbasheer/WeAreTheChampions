//
//  TeamListRowView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct TeamListCardView: View {
    var teamData : TeamData
    var body: some View {
        HStack {
            VStack {
                // MARK: matchPoints
                Text(String(teamData.matchPoints))
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                // MARK: name
                Text(teamData.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                // MARK: date registered
                Text(teamData.date.formatted(.dateTime.month().day()))
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal)
        .padding([.top, .bottom], 8)
    }
}

struct TeamListRowView_Previews: PreviewProvider {
    static var teamDataVM : TeamDataViewModel = {
        let teamDataVM = TeamDataViewModel()
        teamDataVM.teams = textToTeamsDataParser(testCase01Teams)
        return teamDataVM
    }()
    static var previews: some View {
        TeamListCardView(teamData: teamDataVM.teams[0])
            .previewLayout(.sizeThatFits)
    }
}
