//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI
import Combine

struct WordleFieldView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    var body: some View{
        VStack{
            ForEach($viewModel.rows){$row in
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
                            .onReceive(Just(row.fields[number].guess)){ _ in viewModel.oneCharacter(input: &row.fields[number].guess) }
                            .disabled(row.locked)
                            .onSubmit { viewModel.checkWord(row: row) }
                    }
                }
            }
        }
        .padding(5)
        .alert(viewModel.alertTitle, isPresented: $viewModel.isSolved) {
            Button("Nächste Runde", action: viewModel.alertAction)
        } message: {
            Text(viewModel.alertMessage)
        }

    }
    
    init(resetGame: @escaping () -> Void, rows: [FieldRow], chosenWord: ChosenWord) {
        viewModel = ViewModel(resetGame: resetGame, chosenWord: chosenWord, rows: rows)
    }
}
