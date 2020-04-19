//
//  DataLoader.swift
//  iMobility
//
//  Created by Osama Fawzi on 17.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

import RxSwift
import RxSwiftExt

import Alamofire
import RxAlamofire

final class DataLoader {
    
    enum InitError: Swift.Error {
        
        case invalidBase
        
    }
    
    enum LoadingError: Swift.Error {
        
        case network
        case noConnection
        case mapping
        
    }
    
    let baseURL: URL
    let engine: NetworkEngine
    
    // MARK: - Init
    init(base: String = Bundle.main.baseurl,
         engine: NetworkEngine) throws {
        guard let url = URL(string: base) else {
            throw Error(with: InitError.invalidBase)
        }
        self.baseURL = url
        self.engine = engine
    }
    
    // MARK: -
    // MARK: Load
    func loadItems(with cityid:Int) -> Observable<Weather> {
        do {
            let request = try self._constructRequest(with: .weather(id: cityid))
            return self.engine
                .perform(request: request)
                .catchError({ (error) -> Observable<Data> in
                    guard let urlError = error as? URLError,
                        [URLError.networkConnectionLost,
                         URLError.timedOut].contains(urlError.code) else {
                            return Observable.error(Error(with: LoadingError.network, underlyingError: error))
                    }
                    return Observable.error(Error(with: LoadingError.noConnection, underlyingError: error))
                })
                .map({ (data) -> Weather in
                    return try JSONDecoder().decode(Weather.self,
                                                    from: data)
                })
        }
        catch {
            print("Could not decode data with error : \(error)")
            return Observable.error(error)
        }
    }
    
    
    func loadlocalItems() -> Observable<[Model.Service.Item]> {
        
        guard let citiesUrl: URL = Bundle.main.url(forResource: "cityList", withExtension: "json") else {
            return Observable.empty()
        }
        
        do {
            let data = try Data(contentsOf: citiesUrl)
            
            let cities = try JSONDecoder().decode(Model.Service.Items.self, from: data)
            return Observable.once(cities.items)
            
        } catch let error {
            print("Could not parse cities with error : \(error)")
            return Observable.error(error)
        }

        
        
    }
    
    // MARK: - Private
    private func _constructRequest(with relativePath: Endpoints) throws -> Request {
        return try Request(base: self.baseURL,
                           relativePath: relativePath)
    }
    
}

extension DataLoader.InitError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidBase:
            return "An instance couldn't be constructed due to invalid base URL string representation. Please contact support."
        }
    }
    
}

extension DataLoader.LoadingError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .network:
            return "The operation couldn’t be completed due to complication(s) with the network. Please check your connection."
        case .noConnection:
            return "The operation couldn’t be completed due to there is no internet connection. Please check your connection."
        case .mapping:
            return "The operation couldn’t be completed due to error(s) with mapping. Please contact support."
        }
    }
    
}
