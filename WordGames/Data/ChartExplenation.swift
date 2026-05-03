//
//  ChartExplenation.swift
//  WordGames
//
//  Created by Jan Schmidt on 5/3/26.
//

import SwiftUI

struct ChartExplanation: View {
    
    @Binding var showingExplanation: Bool
    
    var body: some View {
                ScrollView{
                    Text("Das Diagramm zeigt, wie oft du bisher wie viele Versuche gebraucht hast. Die y-Achse zeigt die mögliche Anzahl an Versuchen (1-5) und die x-Achse zeigt, wie oft die entsprechend Anzahl benötigt wurde. Am besten ist also ein großer Balken bei \"1\" und am schlechtesten einer bei \"5\". Der Durchschnitt zeigt, wie viele Versuche du durchschnittlich brauchst.")
                }
                .scrollBounceBehavior(.basedOnSize)
                .padding()
                .overlay(alignment: .topTrailing) {
                Button{
                    withAnimation{
                        showingExplanation = false
                    }
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.plain)
                .font(.callout)
            }
    }
}

#Preview {
    ChartExplanation(showingExplanation: .constant(true))
}
