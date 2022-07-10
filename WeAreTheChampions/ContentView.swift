//
//  ContentView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var teamDataVM : TeamDataViewModel
    private var isDataEmpty : Bool {
        return teamDataVM.teams.isEmpty
    }
    @State private var showTeamsInputHelp = false
    @State private var teamInputText: String = ""
    private var submitTeamsButton: some View {
        // MARK: Submit Button
        Button {
            // MARK: Submit data
            teamDataVM.teams = textToTeamsDataParser($teamInputText.wrappedValue)
        } label: {
            Text("Submit")
        }
    }
    private var teamSectionHeader: some View {
        HStack {
            Text("Input your teams here")
            Button {
                showTeamsInputHelp = true
            } label: {
                Image(systemName: "info.circle")
            }
            Spacer()
        }
        .font(.caption)
        .foregroundColor(Color.text)
        .padding(.horizontal)
        .alert(isPresented: $showTeamsInputHelp) {
            Alert(title: Text("Input Format:"), message: Text("<Team A name> <Team A registration date in DD/MM> <Team A group number>"), dismissButton: .default(Text("Okay")))
        }
    }
    private var teamInputSection: some View {
        VStack {
            teamSectionHeader
            
            TextEditor(text: $teamInputText)
                .border(.primary, width: 1)
                .padding(.horizontal)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            submitTeamsButton
        }
    }
    
    @State private var showMatchInputHelp = false
    @State private var matchInputText = ""
    private var matchSectionHeader : some View {
        HStack {
            Text("Enter Match Results here")
            Button {
                showMatchInputHelp = true
            } label: {
                Image(systemName: "info.circle")
            }
            Spacer()
        }
        .font(.caption)
        .foregroundColor(Color.text)
        .padding(.horizontal)
        .alert(isPresented: $showMatchInputHelp) {
            Alert(title: Text("Input Format:"), message: Text("<Team A name> <Team B name> <Team A goals scored> <Team B goals scored>"), dismissButton: .default(Text("Okay")))
        }
    }
    private var submitMatchesButton: some View {
        // MARK: Submit Match Data Button
        Button {
            // MARK: Submit data
            do {
                try playMatches(matchInputText: $matchInputText.wrappedValue, teamData: teamDataVM)
                hasSubmittedMatches.toggle()
            } catch  {
                showMatchInputHelp = true
            }
        } label: {
            Text("Submit")
        }
    }
    @State private var hasSubmittedMatches = false
    private var matchesSection: some View {
        VStack {
            matchSectionHeader
            TextEditor(text: $matchInputText)
                .border(.primary, width: 1)
                .padding(.horizontal)
                .foregroundColor(.primary)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            submitMatchesButton
                .alert(isPresented: $showMatchInputHelp) {
                    Alert(title: Text("Input Format:"), message: Text("<Team A name> <Team B name> <Team A goals scored> <Team B goals scored>"), dismissButton: .default(Text("Okay")))
                }
        }
    }
    
    private var clearAllButton: some View {
        // MARK: Clear All Button
        Button {
            teamDataVM.teams = []
        } label: {
            Text("Clear All")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if isDataEmpty {
                    // MARK: - Team Input Section
                    teamInputSection
                } else {
                    VStack {
                        // MARK: - Teams List Section
                        TeamListView(hasSubmittedMatches: $hasSubmittedMatches)
                            .environmentObject(teamDataVM)
                            .frame(height: 480, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        if hasSubmittedMatches {clearAllButton}
                    }
                    .padding(.bottom, 20)
                    
                    if !hasSubmittedMatches {
                        // MARK: - Match Results Section
                        matchesSection
                    }
                }
            }
            .navigationTitle(isDataEmpty ? "Team Set-up" : "Teams")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var teamDataVM : TeamDataViewModel = {
        let teamDataVM = TeamDataViewModel()
        teamDataVM.teams = textToTeamsDataParser(testCase01Teams)
        return teamDataVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(teamDataVM)
    }
}
