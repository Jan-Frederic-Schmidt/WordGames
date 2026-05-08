//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI
import Combine

struct WordleFieldView: View {
    
    @Binding public var rows: Array<FieldRow>
    @Binding public var chosenWord: ChosenWord
    @Binding public var stat: Statistic
    @State private var isSolved = false
    @State private var isWrong = false
    
    public var resetGame: () -> Void
    
    var body: some View{
        VStack{
            ForEach($rows){$row in
                HStack{
                    ForEach(0..<5){number in
                        TextField("", text: $row.fields[number].guess)
                        //text styling
                            .multilineTextAlignment(.center)
                            .font(.title).bold()
                            .textCase(.uppercase)
                            .autocorrectionDisabled()
                        //frame styling
                            .frame(maxWidth: 80, maxHeight: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .glassEffect(.regular.tint(row.fields[number].color).interactive(), in: .rect(cornerRadius: 10))
                        //executing code
                            .disabled(row.locked)
                            .onReceive(Just(row.fields[number].guess)){ _ in oneCharacter(input: &row.fields[number].guess) }
                            .onReceive(Just(row.fields[number].guess)){ _ in oneCharacter(input: &row.fields[number].guess) }
                            .disabled(row.locked)
                            .onSubmit {
                                checkWord(row: row)
                            }
                    }
                }
            }
        }
        .padding(5)
        .alert("Das war richtig!", isPresented: $isSolved) {
            Button("Ok"){
                stat.streak += 1
                stat.guessSpread.updateValue(stat.guessSpread[chosenWord.guesses, default: 0 ] + 1, forKey: chosenWord.guesses)
                resetGame()
            }
        } message: {
            Text("Super, du hast \(chosenWord.word) herausgefunden!")
        }
        .alert("Das war leider falsch! \(chosenWord.word) war das Wort!", isPresented: $isWrong, actions: {
            Button("Ok"){
                stat.streak = 0
                resetGame()
            }
        })
    }
    
    func checkWord(row: FieldRow){
        if !row.fields.contains(where: {$0.guess == ""}){
            if row.isRealWord(){
                row.locked = true
                chosenWord.guesses += 1
                row.compareWords(chosenWord.characterList)
                isWrong = chosenWord.isWrong
                isSolved = row.isSolved
            }
        }
    }
    
    func oneCharacter (input: inout String){
        if input.count > 1{
            input = String(input.prefix(1))
        }
    }
}
