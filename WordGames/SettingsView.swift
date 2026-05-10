//
//  SettingsView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/8/26.
//

//Color Theme, About, Game Rules, Clear All Data, Language

import SwiftUI

struct SettingsView: View {
    @Binding public var language: Locale.Language
    
    @AppStorage("colorScheme") var storedColorScheme = 0
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink{
                    //go to somewhere
                } label: {
                    Label("Spielregeln", systemImage: "info.circle")
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
                    
                    Picker(selection: $language){
                        Text("Deutsch")
                            .tag(Locale.Language(identifier: "de"))
                        Text("English")
                            .tag(Locale.Language(identifier: "en"))
                        Text("Français")
                            .tag(Locale.Language(identifier: "fr"))
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
            }
            .foregroundStyle(.primary)
            .navigationTitle("Einstellungen")
        }
    }
}
