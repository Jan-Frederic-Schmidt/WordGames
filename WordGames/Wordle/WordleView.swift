//
//  WordleView.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/20/26.
//

import SwiftUI

struct WordleView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var chosenWord = ChosenWord()
    @State private var rows: Array<FieldRow> = []
    @State private var isSolved = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(chosenWord.word)
                ForEach(rows){row in
                    RowView(Row: row, outsideChosenWord: $chosenWord, isSolved: $isSolved)
                }
                
                Text("\(chosenWord.guesses)")
            }
            .padding(.horizontal, 35)
            .navigationTitle("Wordle")
            .toolbar{
                Button("Neues Wort wählen", action: resetGame)
            }
            .alert("Das war richtig!", isPresented: $isSolved) {
                Button("Ok", action: resetGame)
            } message: {
                Text("Super, du hast \(chosenWord.word) herausgefunden!")
            }
            .onAppear{
                rows = createRows()
            }
        }
    }
    
    func createRows() -> Array<FieldRow>{
        [FieldRow(colorScheme), FieldRow(colorScheme), FieldRow(colorScheme), FieldRow(colorScheme), FieldRow(colorScheme)]
    }
    
    func resetGame(){
        rows = createRows()
        chosenWord.chooseNewWord()
    }
}

#Preview {
    WordleView()
}
