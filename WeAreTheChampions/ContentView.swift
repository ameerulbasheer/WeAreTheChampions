//
//  ContentView.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showTeamsInputHelp = false
    @State private var teamInputText = ""
    @State private var showMatchInputHelp = false
    @State private var matchInputText = ""
    var body: some View {
        NavigationView {
            List {
                Section(content: {
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
            .navigationTitle("Team Set-up")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
