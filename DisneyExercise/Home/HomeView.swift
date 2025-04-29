//
//  HomeView.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject private var rootManagerViewModel: RootViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        ZStack {
            ScrollView (.vertical,showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.data, id: \.id) { item in
                        VStack {
                            CardContainer(title: item.name ?? "", isFav: false, onFavTapped: {
                                viewModel.saveCharacter(item)
                            }) {
                                CoverImageView(urlImg: item.imageUrl)
                            }
                        }
                    }
                }.padding()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatFavButton(icon: "star") {
                        viewModel.getCharacterFavorites()
                    }
                    .frame(width: 60)
                    .padding()
                }
            }
            
        }.task {
            Task {
                await  viewModel.loadCharacters()
            }
        }
    }
}

struct HomeView_Preciews: PreviewProvider {
    static var previews: some View {
        let repository = HomeRepository(configService: nil)
        let vm = HomeViewModel(repository: repository )
        vm.data = [CharacterModel(id: 1, name: "miky", imageUrl: "", sourceUrl: "")]
        return HomeView(viewModel: vm)
    }
}


