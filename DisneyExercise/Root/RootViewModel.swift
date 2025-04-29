//
//  RootViewModel.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import Foundation

@MainActor
class RootViewModel: ObservableObject {
    @Published var activeView: ActiveView = .splash

    enum ActiveView {
        case splash
        case Home(viewModel: HomeViewModel)
    }
    
    func getActiveView() async {
        //Inyection DEpendencie
        let configureService: NetworkingConfigurable = ConfigService(
            baseURL: URL(string: "https://api.disneyapi.dev/character")!,
            endPoint: "",
            header: ["Acept":"application/json","Content-Type":"application/json"],
            queryParameters: ["":""])
        let managerService = ServiceManager()
        let serviceHome = CharactersService(serviceConfig: configureService, serviceManagaer: managerService)
        let localConfig = LocalManager()
        
        let repository: HomeRepositoryProtocol = HomeRepository(configService: serviceHome, configLocal: localConfig)
        activeView = .Home(viewModel: HomeViewModel(repository: repository ))
    }
    
}
