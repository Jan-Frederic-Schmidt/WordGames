//
//  ChosenWord.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/15/26.
//

import Foundation
import SwiftUI

struct ChosenWord{
    var wordList: Set<String>
    var word: String {
        didSet{
            characterList = Array(word).convertToStrings()
        }
    }
    var characterList: Array<String>
    
    init(_ wordlist: String){
        wordList = Bundle.main.chooseWord(for: wordlist, withLenght: 5)
        word = wordList.randomElement()!
        characterList = Array(word).convertToStrings()
    }
    
    mutating func chooseNewWord(){
        var newWord = wordList.randomElement()!
        while newWord == word{
            newWord = wordList.randomElement()!
        }
        word = newWord
    }
}
