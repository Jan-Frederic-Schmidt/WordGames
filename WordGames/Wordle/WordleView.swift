//
//  WordleView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/20/26.
//
import Combine
import SwiftUI

struct WordleView: View {
    @State private var chosenWord = ChosenWord()
    @State private var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
    
    @Binding public var stat: Statistic
    
    let colorScheme: ColorScheme
    var backgroundColor: Color {
        switch colorScheme {
        case .light:
            return Color.lightBackground
        case .dark:
            return Color.darkBackground
        default:
            return Color.lightBackground
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 40){
                        Text("Versuche: \(6 - chosenWord.guesses)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        Text("Streak: \(stat.streak)")
//                        Text(chosenWord.word)
                        
                        WordleFieldView(rows: $rows, chosenWord: $chosenWord, stat: $stat, resetGame: resetGame)
                    }
                    .padding(.horizontal, 35)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
                .navigationTitle("Wordle")
                .toolbar{
                    Button("Neues Wort wählen", action: resetGame)
                }
            }
        }
    }
    
    func resetGame(){
        if stat.firstPlayed == nil{
            stat.firstPlayed = .now
        }
        stat.lastPlayed = .now
        stat.timesPlayed += 1
        
        if let data = try? JSONEncoder().encode(stat){
            UserDefaults.standard.set(data, forKey: "Statistic")
        } else {
            fatalError("Couldn't save game")
        }
        
        rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        chosenWord.chooseNewWord()
    }
}
