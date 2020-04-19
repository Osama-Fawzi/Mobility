//
//  Bundle+Extensions.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation


extension Bundle {
    
    var baseurl: String {
        return object(forInfoDictionaryKey: "baseURL") as? String ?? ""
    }
    
    var urlPrefix: String {
        return object(forInfoDictionaryKey: "urlPrefix") as? String ?? ""
    }
    
    var apiKey: String {
        return object(forInfoDictionaryKey: "apiKey") as? String ?? ""
    }
    
}
