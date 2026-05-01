//
//  WordleView.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/20/26.
//

import SwiftUI

struct WordleView: View {
    @State private var chosenWord = ChosenWord()
    @State private var rows: Array<FieldRow> = []
    @State private var isSolved = false
    @State private var isWrong = false
    
    @Binding public var stat: Statistic
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 40){
                Text("Versuche: \(chosenWord.guesses)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Text(chosenWord.word)
                VStack{
                    ForEach(rows){row in
                        RowView(Row: row, outsideChosenWord: $chosenWord, isSolved: $isSolved, isWrong: $isWrong)
                    }
                    .padding(5)
                }
            }
            .padding(.horizontal, 35)
            .navigationTitle("Wordle")
            .toolbar{
                Button("Neues Wort wählen", action: resetGame)
            }
            .alert("Das war richtig!", isPresented: $isSolved) {
                Button("Ok"){
                    stat.streak += 1
                    stat.guessSpread.updateValue(stat.guessSpread[chosenWord.guesses, default: 0 ] + 1, forKey: chosenWord.guesses)
                    if stat.firstPlayed == nil{
                        stat.firstPlayed = .now
                    }
                    stat.lastPlayed = .now
                    stat.timesPlayed += 1
                    resetGame()
                }
            } message: {
                Text("Super, du hast \(chosenWord.word) herausgefunden!")
            }
            .alert("Das war leider falsch", isPresented: $isWrong, actions: {
                Button("Ok"){
                    stat.streak = 0
                    stat.guessSpread.updateValue(stat.guessSpread[chosenWord.guesses, default: 0 ] + 1, forKey: 5)
                    if stat.firstPlayed == nil{
                        stat.firstPlayed = .now
                    }
                    stat.lastPlayed = .now
                    stat.timesPlayed += 1
                    resetGame()
                }
            })
            .onAppear{
                rows = createRows()
            }
        }
    }
    
    func createRows() -> Array<FieldRow>{
        [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
    }
    
    func resetGame(){
        if let data = try? JSONEncoder().encode(stat){
            UserDefaults.standard.set(data, forKey: "Statistic")
        } else {
            fatalError("Couldn't save game")
        }
        
        rows = createRows()
        chosenWord.chooseNewWord()
    }
}

//#Preview {
//    WordleView()
//}
