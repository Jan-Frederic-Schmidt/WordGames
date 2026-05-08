//
//  StatView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/1/26.
//
import Charts
import SwiftUI

struct StatView: View {
    
    @State private var showingExplanation = false
    
    public var stat:  Statistic
    public var colorScheme: ColorScheme
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("\(stat.timesPlayed) Mal gespielt")
                    Text("Du hast eine Streak von \(stat.streak)")
                }
                
                Text("Erstes Mal gespielt: \(stat.firstPlayed?.formatted(date: .long, time: .omitted) ?? "Noch nicht gespielt")")
                Text("Letztes Mal gespielt: \(stat.lastPlayed?.formatted(date: .long, time: .shortened) ?? "Noch nicht gespielt")")
                Text("Du hast \(stat.consecutiveDays) Tage hintereinander gespielt")
                
                Section("Benötigte Versuche"){
                    Group{
                        if showingExplanation{
                            ChartExplanation(showingExplanation: $showingExplanation)
                        } else {
                            Chart{
                                ForEach(1..<7, id: \.self){number in
                                    BarMark(
                                        x: .value("Wörter, die so viele Versuche gebrauht haben", stat.guessSpread[number]!),
                                        y: .value("Anzahl der Versuche", String(number))
                                    )
                                    
                                }
                            }
                            .chartYAxisLabel("Zahl der Spiele", alignment: .topLeading)
                            .chartXAxisLabel("Zahl der Versuche")
                            .foregroundStyle(Color.accentColor)
                            .overlay(alignment: .topTrailing) {
                                Button{
                                    withAnimation{
                                        showingExplanation = true
                                    }
                                } label: {
                                    Image(systemName: "questionmark.circle")
                                }
                                .buttonStyle(.plain)
                                .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    .frame(height: 400)
                }
            }
            .background(colorScheme == .light ? .lightBackground : .darkBackground)
            .scrollContentBackground(.hidden)
            .navigationTitle("Statistiken")
        }
    }
}

//#Preview {
//    StatView()
//}

//Chart{
//    BarMark(
//        x: .value("The other value", 4),
//        y: .value("Number of Guesses", "Test")
//    )
//    
//    BarMark(
//        x: .value("The other value", 5),
//        y: .value("Number of Guesses", "what")
//    )
//    
//    BarMark(
//        x: .value("The other value", 2),
//        y: .value("Number of Guesses", "another test")
//    )
//}
//.padding()
