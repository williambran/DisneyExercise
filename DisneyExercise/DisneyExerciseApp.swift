//
//  DisneyExerciseApp.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import SwiftUI

@main
struct DisneyExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(rootManagerViewModel: RootViewModel())
        }
    }
}
