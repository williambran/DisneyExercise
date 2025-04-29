//
//  CardContainer.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import SwiftUI

struct CardContainer<Content: View>: View {
    var title: String
    var isFav: Bool
    var onFavTapped: () -> Void
    
    @ViewBuilder var content: () -> Content
    
    
    var body: some View {
        ZStack() {
            content()
            VStack {
                Spacer()
                HStack() {
                    Text(title).foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        if !isFav {
                            onFavTapped()
                        }
                    }) {
                        Image(systemName: isFav ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                }
                .frame(height: 40)
                .padding(.horizontal)
                .background(Color.black.opacity(0.6))
            }
        }
        .cornerRadius(20)
    }
}

#Preview {
    CardContainer(title: "Perry", isFav: true, onFavTapped: {
        print("actionbtnFav")
    }) {
        CoverImageView(urlImg: "")
    }
}
