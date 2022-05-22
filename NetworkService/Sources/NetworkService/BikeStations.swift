//
//  BikeStations.swift
//  Digikraft-BikeStation
//
//  Created by Jithin M on 22/05/22.
//

import Foundation

// MARK: - Welcome
struct BikeStationsList: Codable {
    let features: [BikeStation]
    let crs: CRS
    let type: String
}

// MARK: - CRS
struct CRS: Codable {
    let type: String
    let properties: CRSProperties
}

// MARK: - CRSProperties
struct CRSProperties: Codable {
    let code: String
}

// MARK: - Feature
struct BikeStation: Codable {
    let geometry: Geometry
    let id: String
    let type: FeatureType
    let properties: FeatureProperties
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [Double]
    let type: GeometryType
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let freeRacks, bikes, label, bikeRacks: String
    let updated: Updated

    enum CodingKeys: String, CodingKey {
        case freeRacks = "free_racks"
        case bikes, label
        case bikeRacks = "bike_racks"
        case updated
    }
}

enum Updated: String, Codable {
    case the202205221056 = "2022-05-22 10:56"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

