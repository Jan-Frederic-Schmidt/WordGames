//
//  SettingsView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/8/26.
//

//Color Theme, About, Game Rules, Clear All Data, Language

import SwiftUI

struct SettingsView: View {
    @Binding public var colorScheme: ColorScheme?
    @Binding public var language: Locale.Language
    @Binding public var stat: Statistic
    
    let colorSchemes: Array<ColorScheme?> = [nil, .light, .dark]
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink{
                    //go to somewhere
                } label: {
                    Label("Spielregeln", systemImage: "info.circle")
                }
                
                Section{
                    Picker(selection: $colorScheme){
                        ForEach(colorSchemes, id: \.self){
                            switch $0{
                            case .light:
                                return Text("Hell")
                            case .dark:
                                return Text("Dunkel")
                            default:
                                return Text("Gerät")
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
                        stat = Statistic()
                        if let data = try? JSONEncoder().encode(stat){
                            UserDefaults.standard.set(data, forKey: "Statistic")
                        } else {
                            fatalError("Couldn't save game")
                        }
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
