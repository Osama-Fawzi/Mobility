//
//  Bundle+Extensions.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation


import RxSwift
import Action

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


public extension RxSwift.ObservableType {
    
    func bind<ValueType>(to action: Action<ValueType, ValueType>) -> Disposable where ValueType == Element {
        return self.bind(to: action.inputs)
    }
    
    func bind<ValueType, OutputValueType>(to action: Action<ValueType, OutputValueType>) -> Disposable where ValueType == Element {
        return self.bind(to: action.inputs)
    }
    
    func bind<ValueType, InputValueType, OutputValueType>(to action: Action<InputValueType, OutputValueType>, inputTransform: @escaping (ValueType) -> (InputValueType)) -> Disposable where ValueType == Element {
        return self
            .map({ (input: ValueType) -> InputValueType in
                return inputTransform(input)
            })
            .bind(to: action.inputs)
    }
    
}
