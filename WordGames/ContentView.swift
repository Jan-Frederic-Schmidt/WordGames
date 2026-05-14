//
//  ContentView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/23/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            WordleView()
                .tabItem{
                    Label("Wordle", systemImage: "w.square.fill")
                }
            
            StatView()
                .tabItem{
                    Label("Statistiken", systemImage: "chart.xyaxis.line")
                }
            
            SettingsView()
                .tabItem{
                    Label("Einstellungen", systemImage: "gear")
                }
        }
    }
}

//#Preview {
//    ContentView()
//}
