//
//  StatView.swift
//  WordGames
//
//  Created by Jan Schmidt on 5/1/26.
//
import Charts
import SwiftUI

struct StatView: View {
    
    public var stat:  Statistic
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("\(stat.timesPlayed) Mal gespielt")
                    Text("Du hast eine Streak von \(stat.streak)")
                    Text("Durchschnittliche Versuche: \(stat.averageGuesses)")
                }
                
                Text("Erstes Mal gespielt: \(stat.firstPlayed?.formatted(date: .long, time: .omitted) ?? "Not played yet")")
                Text("Letztes Mal gespielt: \(stat.lastPlayed?.formatted(date: .long, time: .omitted) ?? "Not played yet")")
                
                Section{
                    Chart{
                        ForEach(1..<6, id: \.self){number in
                            BarMark(
                                x: .value("Wörter, die so viele Versuche gebrauht haben", stat.guessSpread[number]!),
                                y: .value("Anzahl der Versuche", String(number))
                            )
                        }
                    }
                    .frame(height: 400)
                }
            }
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
