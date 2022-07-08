//
//  ContentView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var teamDataVM : TeamDataViewModel
    @State private var showTeamsInputHelp = false
    @State private var teamInputText = ""
    @State private var showMatchInputHelp = false
    @State private var matchInputText = ""
    
    var body: some View {
        NavigationView {
            List {
                if teamDataVM.teams.isEmpty {
                    // MARK: - Team Input Section
                    Section(content: {
                        VStack {
                            ZStack(alignment: .leading) {
                                if teamInputText.isEmpty {
                                    HStack {
                                        Text("<Team A name> <Team A registration date in DD/MM> <Team A group number>")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                                TextEditor(text: $teamInputText)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                            // MARK: Submit Button
                            Button {
                                // MARK: Submit data
                                teamDataVM.teams = textToTeamsDataParser(teamInputText)
                            } label: {
                                Text("Submit")
                            }
                        }
                    }, header: {
                        HStack {
                            Text("Input your teams here")
                            Button {
                                showTeamsInputHelp = true
                            } label: {
                                Image(systemName: "info.circle")
                            }
                        }
                        .alert(isPresented: $showTeamsInputHelp) {
                            Alert(title: Text("Input Format:"), message: Text("<Team A name> <Team A registration date in DD/MM> <Team A group number>"), dismissButton: .default(Text("Okay")))
                        }
                    })
                } else {
                    // MARK: Fill Up Team details
                    TeamListView(teams: teamDataVM.teams)
                        .frame(height: 200, alignment: .top)
                }
                
                // MARK: - Match Results Section
                Section(content: {
                    ZStack(alignment: .leading) {
                        if matchInputText.isEmpty {
                            HStack {
                                Text("<Team A name> <Team B name> <Team A goals scored> <Team B goals scored>")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                        TextEditor(text: $matchInputText)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                }, header: {
                    HStack {
                        Text("Enter Match Results here")
                        Button {
                            showMatchInputHelp = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    .alert(isPresented: $showMatchInputHelp) {
                        Alert(title: Text("Input Format:"), message: Text("<Team A name> <Team B name> <Team A goals scored> <Team B goals scored>"), dismissButton: .default(Text("Okay")))
                    }
                })
            }
            .navigationTitle(teamDataVM.teams.isEmpty ? "Team Set-up" : "Teams")
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
