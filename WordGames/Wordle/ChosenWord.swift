//
//  ChosenWord.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/15/26.
//

import Foundation
import SwiftUI

struct ChosenWord{
    var wordList = Bundle.main.chooseWord(for: "wordlist.txt", withLenght: 5)
    var word: String {
        didSet{
            characterList = Array(word).convertToStrings()
        }
    }
    var guesses = 0
    var characterList: Array<String>
    
    init(){
        word = wordList.randomElement()!
        characterList = Array(word).convertToStrings()
    }
    
    mutating func chooseNewWord(){
        var newWord = Bundle.main.chooseWord(for: "wordlist.txt", withLenght: 5).randomElement()!
        while newWord == word{
            newWord = Bundle.main.chooseWord(for: "wordlist.txt", withLenght: 5).randomElement()!
        }
        word = newWord
        guesses = 0
    }
}
