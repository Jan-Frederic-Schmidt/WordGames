//
//  SettingsView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/8/26.
//

//Color Theme, About, Game Rules, Clear All Data, Language

import SwiftUI

struct SettingsView: View {
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    @AppStorage("colorScheme") var storedColorScheme = 0
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink{
                    GameRulesView()
                } label: {
                    Label("Spielregeln", systemImage: "text.page")
                }
                
                Section{
                    Picker(selection: $storedColorScheme){
                        ForEach(0..<3){
                            switch $0{
                            case 0:
                                Text("Gerät")
                                    .tag($0)
                            case 1:
                                Text("Hell")
                                    .tag($0)
                            default:
                                Text("Dunkel")
                                    .tag($0)
                            }
                        }
                    } label: {
                        Label("Wähle ein Farbscheme aus", systemImage: "paintpalette")
                    }
                    
                    Picker(selection: $languageIdentifier){
                        Text("Gerät")
                            .tag("auto")
                        Text("Deutsch")
                            .tag("de")
                        Text("English")
                            .tag("en")
                        Text("Français")
                            .tag("fr")
                    } label: {
                        Label("Wähle eine Sprache aus", systemImage: "translate")
                    }
                    
                    Button(role: .destructive){
                        UserDefaults.standard.removeObject(forKey: "Statistic")
                        stat.statistic = getStatistic()
                    } label: {
                        Label("Alle Daten löschen", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("Über die App", systemImage: "info.circle")
                    }
                }
            }
            .foregroundStyle(.primary)
            .navigationTitle("Einstellungen")
        }
    }
}

