//
//  CoverImageView.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/28/25.
//

import SwiftUI

struct CoverImageView: View {
    @ObservedObject var viewModel: CoverImageViewModel
    var image: UIImage? {
        viewModel.data.flatMap(UIImage.init)
    }
    
    init(urlImg: String?){
        viewModel = CoverImageViewModel(url: urlImg)
    }
    
    var body: some View {
        Image(uiImage: image ?? UIImage(systemName: "photo")!)
            .resizable()
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    CoverImageView(urlImg: "")
}
