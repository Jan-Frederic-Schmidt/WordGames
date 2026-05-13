//
//  WordleViewModel.swift
//  WordGames
//
//  Created by Jan Schmidt on 5/13/26.
//

import Combine
import Foundation

extension WordleView {
    class ViewModel: ObservableObject {
        @Published var chosenWord = ChosenWord("wordlist-german.txt")
        @Published var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        var guesses = 0
        
        func resetGame(){
            if stat.statistic.firstPlayed == nil{
                stat.statistic.firstPlayed = .now
            }
            stat.statistic.lastPlayed = .now
            
            if let data = try? JSONEncoder().encode(stat.statistic){
                UserDefaults.standard.set(data, forKey: "Statistic")
            } else {
                fatalError("Couldn't save game")
            }
            
            rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
            chosenWord.chooseNewWord()
            guesses = 0
        }
    }
}
