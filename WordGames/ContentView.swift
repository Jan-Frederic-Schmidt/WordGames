//
//  ContentView.swift
//  WordGames
//
//  Created by Jan Schmidt on 4/23/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var statistic: Statistic = getStatistic()
    var body: some View {
        TabView{
            WordleView(stat: $statistic)
                .tabItem{
                    Label("Wordle", systemImage: "w.square.fill")
                }
            
            StatView(stat: statistic)
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

//#Preview {
//    ContentView()
//}
