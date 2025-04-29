//
//  FloatFavButton.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

import SwiftUI

struct FloatFavButton: View {
    
    var icon: String
    var action: () async -> Void
    
    var body: some View {
        Button( action: {
            Task {
                await action()
            }
        }, label: {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .padding(16)
                .background(Color.yellow)
                .clipShape(Circle())
                .shadow(radius: 5)
                .foregroundColor(Color.white)
        })
    }
}

#Preview {
    FloatFavButton( icon: "star") {
        
    }
}
