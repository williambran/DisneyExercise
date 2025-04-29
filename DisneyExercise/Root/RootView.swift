//
//  RootView.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var rootManagerViewModel: RootViewModel
    
    var body: some View {
        VStack {
            rootView()
        }.task {
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                await rootManagerViewModel.getActiveView()
            
        }
    }
    
    
    @ViewBuilder
    func rootView() -> some View {
        switch rootManagerViewModel.activeView {
        case .splash:
            Text("Disney Characters")
                .font(.system(size: 58, weight: .bold, design: .rounded))
                .foregroundColor(.indigo)
                .padding()
                .multilineTextAlignment(.center)
                .background {
                    Image("bg_home-800")
                    
                }
        case .Home(viewModel: let viewModel):
            HomeView(viewModel: viewModel)
        }
    }
}

#Preview {
    RootView(rootManagerViewModel: RootViewModel())
}
