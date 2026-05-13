//
//  WordleFieldModel.swift
//  WordGames
//
//  Created by Jan Schmidt on 5/13/26.
//

import Combine
import Foundation

extension WordleFieldView {
    class ViewModel: ObservableObject {
        
        var isSolved = false
        
        var alertTitle = ""
        var alertMessage = ""
        var alertAction = { }
        
        var resetGame: () -> Void
        
        @Published var chosenWord: ChosenWord
        @Published var rows: [FieldRow]
        
        func oneCharacter (input: inout String){
            if input.count > 1{
                input = String(input.prefix(1))
            }
        }
        
        func checkWord(row: FieldRow){
            if !row.fields.contains(where: {$0.guess == ""}){
                if chosenWord.wordList.contains(row.makeRealWord()){
                    row.locked = true
                    chosenWord.guesses += 1
                    row.compareWords(chosenWord.characterList)
                    setAlert(row.isSolved)
                }
            }
        }
        
        func setAlert(_ isCorrect: Bool) {
            if isCorrect {
                alertTitle = "Richtig!"
                alertMessage = "Super, du hast \(chosenWord.word) erraten!"
                alertAction = {
                    stat.statistic.streak += 1
                    stat.statistic.timesPlayed += 1
                    stat.statistic.guessSpread.updateValue(stat.statistic.guessSpread[self.chosenWord.guesses, default: 0 ] + 1, forKey: self.chosenWord.guesses)
                    self.resetGame()
                }
                
                isSolved = true
            } else {
                if chosenWord.guesses >= 6 {
                    alertTitle = "Leider Falsch!"
                    alertMessage = "Das war leider falsch. Das Wort war \(chosenWord.word)"
                    alertAction = {
                        stat.statistic.streak = 0
                        stat.statistic.timesPlayed += 1
                        self.resetGame()
                    }
                    
                    isSolved = true
                }
            }
        }
        
        init(resetGame: @escaping () -> Void, chosenWord: ChosenWord, rows: [FieldRow]) {
            self.resetGame = resetGame
            self.chosenWord = chosenWord
            self.rows = rows
        }
    }
}
