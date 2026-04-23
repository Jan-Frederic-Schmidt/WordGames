//
//  ContentView.swift
//  WordScramble
//
//  Created by Jan Schmidt on 3/29/2026.
//

import SwiftUI

struct WordScrambleView: View {
    @State private var usedWords: Array<String> = []
    @State private var rootWord = Bundle.main.chooseWord(for: "wordlist.txt", withLenght: 8).randomElement()!
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Gebe dein Wort ein", text: $newWord)
                        .onSubmit(addNewWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Dein Score ist \(score)"){
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .alert(errorTitle, isPresented: $showingError){ }message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Neues Spiel"){
                    usedWords = []
                    score = 0
                    newWord = ""
                    rootWord = Bundle.main.chooseWord(for: "wordlist.txt", withLenght: 8).randomElement()!
                }
            }
            }
        }
    
    func addNewWord(){
        let uppercased = newWord.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if uppercased.isEmpty || usedWords.contains(uppercased) || uppercased == rootWord{
            return
        }
        
        guard isReal(uppercased.capitalizingFirstLetter()) else {
            wordError(title: "Kein echtes Wort", message: "Du hast das Wort entweder falsch geschrieben oder es existiert nicht.")
            return
        }
        
        guard viableAnswer(uppercased) else {
            wordError(title: "Keine valide Antwort", message: "\(newWord.trimmingCharacters(in: .whitespacesAndNewlines)) passt nicht in \(rootWord)")
            return
        }
        
        guard lessThanThree(uppercased) else {
            wordError(title: "Word ist zu kurz", message: "Dein Wort war kürzer als drei Buchstaben.")
            return
        }
        
        withAnimation{
            usedWords.insert(uppercased, at: 0)
        }
        score += uppercased.count
        newWord = ""
    }
    
    func viableAnswer(_ word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "de")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func lessThanThree(_ word: String) -> Bool{
        if word.count < 3{
            return false
        }
        return true
    }
}

#Preview {
    WordScrambleView()
}

