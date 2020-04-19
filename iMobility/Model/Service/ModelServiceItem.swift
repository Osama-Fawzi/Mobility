//
//  ModelServiceItem.swift
//  iMobility
//
//  Created by Osama Fawzi on 17.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

extension Model.Service {
    
    struct Item {
        
        let identifier: Int
        let title: String
        let state: String
        let country: String
        let coordinate: Coordinate
        
    }
    
    struct Coordinate {
        let longitude: Double
        let latitude: Double
    }
    
}




extension Model.Service.Coordinate: Codable{
    private enum CodingKeys: String, CodingKey {
        
        case longitude = "lat"
        case latitude = "lon"

    }
}

extension Model.Service.Item: Codable {
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        case title = "name"
        case state = "state"
        case country = "country"
        case coordinate = "coord"

    }
    
}

extension Model.Service.Item: Equatable { }
extension Model.Service.Coordinate: Equatable { }

extension Model.Service.Item {
    
    var description: String {
        return "\(country),\(state)"
    }

}
