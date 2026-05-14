//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI
import Combine

struct WordleFieldView: View {
    
    @ObservedObject public var gameState = GameState()
    
    var body: some View{
        VStack{
            ForEach($gameState.rows){$row in
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
                            .onReceive(Just(row.fields[number].guess)){ _ in gameState.oneCharacter(input: &row.fields[number].guess) }
                            .disabled(row.locked)
                            .onSubmit { gameState.checkWord(row: row) }
                    }
                }
            }
        }
        .padding(5)
        .alert(gameState.alertTitle, isPresented: $gameState.isSolved) {
            Button("Nächste Runde", action: gameState.alertAction)
        } message: {
            Text(gameState.alertMessage)
        }

    }
}
