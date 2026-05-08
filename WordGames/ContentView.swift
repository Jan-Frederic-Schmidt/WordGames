//
//  ContentView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/23/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var deviceColorScheme
    @State private var colorScheme: ColorScheme?
    
    @State private var language = Locale.current.language
    
    @State var statistic: Statistic = getStatistic()
    var body: some View {
        TabView{
            WordleView(stat: $statistic, colorScheme: colorScheme ?? deviceColorScheme)
                .tabItem{
                    Label("Wordle", systemImage: "w.square.fill")
                }
            
            StatView(stat: statistic, colorScheme: colorScheme ?? deviceColorScheme)
                .tabItem{
                    Label("Statistiken", systemImage: "chart.xyaxis.line")
                }
            
            SettingsView(colorScheme: $colorScheme, language: $language, stat: $statistic)
                .tabItem{
                    Label("Einstellungen", systemImage: "gear")
                }
        }
        .preferredColorScheme(colorScheme)
    }
}

//#Preview {
//    ContentView()
//}
