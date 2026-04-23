//
//  RowView.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI
import Combine

struct RowView: View {
    @State public var Row: FieldRow
    @Binding public var outsideChosenWord: ChosenWord
    @Binding public var isSolved: Bool

    var body: some View {
        HStack{
            ForEach(0..<5){number in
                TextField("", text: $Row.fields[number].guess)
                //text styling
                    .multilineTextAlignment(.center)
                    .font(.title).bold()
                    .textCase(.uppercase)
                //frame styling
                    .frame(maxWidth: 110, maxHeight: 110)
                    .aspectRatio(1/1, contentMode: .fit)
                    .glassEffect(.regular.tint(Row.fields[number].color).interactive(), in: .rect(cornerRadius: 20))
                //executing code
                    .disabled(Row.locked)
                    .onReceive(Just(Row.fields[number].guess)){ _ in oneCharacter(input: &Row.fields[number].guess) }
                    .onSubmit {
                        if lockFields(){
                            if Row.isRealWord(){
                                outsideChosenWord.guesses += 1
                                Row.locked = true
                                Row.compareWords(outsideChosenWord.characterList)
                                isSolved = Row.isSolved
                            }
                        }
                    }
            }
        }

    }
    
    func oneCharacter (input: inout String){
        if input.count > 1{
            input = String(input.prefix(1))
        }
    }
    
    func lockFields() -> Bool{
        if !Row.fields.contains(where: {$0.guess == ""}){
            return true
        }
        return false
    }
}

