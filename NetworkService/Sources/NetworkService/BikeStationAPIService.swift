//
//  File.swift
//  
//
//  Created by Jithin M on 22/05/22.
//

import Foundation

struct BikeStationListRequest: DataRequest {
    
    typealias Response = BikeStationsList
    
    var urlString: String {
        let baseUrl = "https://urldefense.proofpoint.com"
        let path = "/v2/url"
        return baseUrl + path
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParams: [String : String] {
        ["u": "http-3A__www.poznan.pl_mim_plan_map-5Fservice.html-3Fmtype-3Dpub-5Ftransport-26co-3Dstacje-5Frowerowe",
         "d": "DwMFaQ",
         "c": "slrrB7dE8n7gBJbeO0g-IQ",
         "r": "7KqbImkapN2a2V0t8lnd0sdXPhKRqZfWKdtKYdfyYLk",
         "m": "GOeP-I9HkpMWrrqggwcmpuLduk0C9umq_zlZsgPe3QA",
         "s": "ibzScnWQ_bOFrc4U7zkaME_RsEWE1ZqLfu8XeepbX6I"]
    }
    
    func decode(data: Data) throws -> BikeStationsList {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(BikeStationsList.self, from: data)
    }
    
}
