//
//  GameRulesView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//

import SwiftUI

struct GameRulesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Spielregeln") {
                    Text("""
                    Wordle ist ein bekanntes Spiel des Entwicklers Josh Wardle, das 2022 von der New York Times gekauft wurde.
                    
                    Das Ziel des Spiels ist einfach: Errate ein Wort durch Ausprobieren anderer Wörter. Pro Feld gibst du dazu einen Buchstaben ein, zusammen ergibt eine Zeile dann dein Wort. Deine Lösungswörter müssen echte Wörter sein und sich im selben Pool wie die Zielwörter befinden. Wenn ein Wort also nicht als solches erkannt wird, trifft eines dieser Kriterien nicht zu. 
                    
                    Danach wertet die App dein Lösungswort auf der Buchstabenebene aus: Ein grauer Hintergrund steht für Buchstaben, die im Zielwort nicht vorkommen. Ein gelber Hintergrund steht für Buchstaben, die im Zielwort an einer anderen Stelle vorkommen, als beim Lösungswort. Und ein grüner Hintergrund steht für Buchstaben, die im Zielwort an der gleichen Stelle vorkommen, wie beim Lösungswort. 
                    
                    Bestätigt wird ein Wort, indem du auf ⏎ drückst. Du hast sechs Versuche pro Lösungswort. 
                    """)
                }
                
                Section("Verbotene Buchstaben") {
                    Text("ß")
                }
            }
            .navigationTitle("Spielregeln")
        }
    }
}
