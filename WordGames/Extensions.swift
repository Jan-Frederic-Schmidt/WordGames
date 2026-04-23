//
//  Extensions.swift
//  Wordle
//
//  Created by Jan Schmidt on 4/10/2026.
//

import Foundation

extension Bundle{
    func chooseWord(for name: String, withLenght length: Int) -> Set<String>{
        if let wordlistURL = Bundle.main.url(forResource: name, withExtension: nil){
            if let wordlist = try? String(contentsOf: wordlistURL, encoding: .utf8) {
                    
                let allWords = wordlist.components(separatedBy: .newlines)
                    
                return Set(allWords.filter { $0.count == length })
                    
                } else {
                    fatalError("Could not import list of words")
                }
            } else {
                fatalError("Could not find list of words")
            }
        }
}

extension Array<Character> {
    func convertToStrings() -> Array<String>{
        var newArray: Array<String> = []
        for i in self{
            newArray.append(String(i))
        }
        
        return newArray
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
