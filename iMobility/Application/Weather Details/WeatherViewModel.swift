//
//  WeatherViewModel.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay
import RxSwiftExt
import RxOptional
import Action

protocol WeatherDataLoader {
            
    func loadItems(with cityid:Int) -> Observable<Weather>
    
}

extension DataLoader: WeatherDataLoader {

}

protocol WeatherViewModelProtocol {
        
    var data: Observable<Weather> { get }
    var error: Observable<Swift.Error> { get }
    var isLoading: Observable<Bool> { get }
        
    var fetchAction: Action<Void, Weather> { get }
    
    init(dataLoader: WeatherDataLoader, cityId: Int)
    
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    
    let dataLoader: WeatherDataLoader
    
    let cityId: Int

    private let disposeBag = DisposeBag()
        
    private let dataSubject = PublishSubject<Weather>()
    
    var data: Observable<Weather> {
        return self.dataSubject
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
    }
    
    var error: Observable<Swift.Error> {
        return self.fetchAction.underlyingError
    }
    
    var isLoading: Observable<Bool> {
        return self.fetchAction.executing
    }
        
    private(set) lazy var fetchAction: Action<Void, Weather> = self.createFetchAction()
    
    init(dataLoader: WeatherDataLoader, cityId: Int) {
        self.dataLoader = dataLoader
        self.cityId = cityId
        self.fetchAction
            .elements
            .bind(to: self.dataSubject)
            .disposed(by: self.disposeBag)
        
      
    }
    
}

// MARK: - Create
extension WeatherViewModel {
    
    private func createFetchAction() -> Action<Void, Weather> {
        return Action { [unowned self] () -> Observable<Weather> in
            return self.dataLoader.loadItems(with: self.cityId)
        }
    }
    
}
