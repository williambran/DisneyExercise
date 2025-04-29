//
//  CoverImageViewModel.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/28/25.
//
import SwiftUI

class CoverImageViewModel: ObservableObject {
    @Published var data: Data? = nil
    var urlSession: URLSession
    var isImgLoaded = false
    private static var imageCache: [String: Data] = [:]
    
    
    init(url: String?) {
        self.urlSession = URLSession.shared
        guard let urlImg = url else { return  }
        
        if let cacheImg = Self.imageCache[urlImg]{
            data = cacheImg
        } else {
            Task {
                await loadImage(from: urlImg)
            }
        }
    }
    
    private func loadImage(from url: String) async {
        guard let imageURL = URL(string: url) else {
            print("URL no válida")
            return
        }
        do {
            let (data, _) = try await urlSession.data(from: imageURL)
            DispatchQueue.main.async {
                self.data = data
                Self.imageCache[url] = data
            }
        } catch {
            print("Some error to download Img \(error)")
        }
    }
}
