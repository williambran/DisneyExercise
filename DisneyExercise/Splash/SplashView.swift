//
//  SplashView.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/28/25.
//

import SwiftUI

struct SplashView: View {

    var body: some View {
        ZStack {
            Text("Este es el Spalhs")
        }.onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.spring()) {
                    
                }
            }
        }
    }
    
}

#Preview {
    SplashView()
}
