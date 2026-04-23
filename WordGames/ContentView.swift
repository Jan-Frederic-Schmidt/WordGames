//
//  ContentView.swift
//  WordGames
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
                
                WordScrambleView()
                    .tabItem{
                        Label("WordScramble", systemImage: "textformat.characters.arrow.left.and.right")
                    }
                
                ProgressView()
                    .tabItem{
                        Label("Stats", systemImage: "chart.xyaxis.line")
                    }
                
                ProgressView()
                    .tabItem{
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
}

#Preview {
    ContentView()
}
