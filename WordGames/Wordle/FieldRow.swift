//
//  FieldStruct.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/7/2026.
//

import Foundation
import SwiftUI

@Observable
class FieldRow: Identifiable{
    class Field{
        var guess: String = ""{
            didSet{
                guess = guess.uppercased()
            }
        }
        var color = Color.white.opacity(0)
    }
    
    var id = UUID()
    var fields = [Field(), Field(), Field(), Field(), Field()]
    var locked = false
    var isSolved = false
    
    //THE FOLLOWING FUNCTION WAS MADE BY AI, SADLY
    
    func compareWords(_ comLetters: Array<String>) {
        var usedIndices = Set<Int>() // Track which indices in the target word have been matched
        
        // First pass: Mark green (correct position)
        for i in 0..<5 {
            if comLetters[i] == fields[i].guess {
                fields[i].color = .green
                usedIndices.insert(i)
            }
        }
        
        if fields.filter({ $0.color == .green}).count == 5{
            isSolved = true
        }

        // Second pass: Mark orange (correct letter, wrong position)
        for i in 0..<5 {
            if fields[i].color != .green {
                let guessChar = fields[i].guess
                // Check if the letter exists in the target word and hasn't been fully matched yet
                let totalInstancesInTarget = comLetters.filter { $0 == guessChar }.count
                let alreadyMatchedInstances = usedIndices.filter { comLetters[$0] == guessChar }.count

                if comLetters.contains(guessChar) && alreadyMatchedInstances < totalInstancesInTarget {
                    fields[i].color = .orange
                    // Mark the first unmatched occurrence in the target word as used
                    if let firstUnmatchedIndex = comLetters.firstIndex(where: { $0 == guessChar && !usedIndices.contains(comLetters.firstIndex(of: $0)!) }) {
                        usedIndices.insert(firstUnmatchedIndex)
                    }
                }
            }
        }
    }
    
    //End of AI
    func isRealWord() -> Bool{
        var word = ""
        
        for field in fields{
            word += field.guess
        }
        
        return WordScrambleView().isReal(word.capitalizingFirstLetter())
    }
    
}
