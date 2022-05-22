//
//  BikeStationListViewModel.swift
//  Digikraft-BikeStation
//
//  Created by Jithin M on 22/05/22.
//

import Foundation
import NetworkService

protocol BikeStationListViewModelProtocol {
    var bikeStationViewModels: [BikeStationViewModel]? { get set }
    func fetchBikeStations()
}

class BikeStationListViewModel: BikeStationListViewModelProtocol, ObservableObject {
    
    private let networkService: NetworkService
    
    @Published var bikeStationViewModels: [BikeStationViewModel]?
    
    init(service: NetworkService = NetworkService()) {
        self.networkService = service
    }
    
    func fetchBikeStations() {
        
    }
    
}

protocol BikeStationViewModelProtocol {
    var stationName: String { get }
    var stationDistance: String? { get }
    var availableBikes: String { get }
    var availablePlaces: String { get }
}

class BikeStationViewModel: BikeStationViewModelProtocol {
    
    var stationName: String {
        return ""
    }
    
    var stationDistance: String? {
        return ""
    }
    
    var availableBikes: String {
        return ""
    }
    
    var availablePlaces: String {
        return ""
    }
    
    
}
