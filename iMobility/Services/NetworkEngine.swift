//
//  NetworkEngine.swift
//  iMobility
//
//  Created by Osama Fawzi on 17.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

import RxSwift

import Alamofire
import RxAlamofire

struct Request {
    
    enum InitError: Swift.Error {
        
        case base
        case relative
        
    }
    
    fileprivate enum Method {
    
        case get
        
    }
    
    let url: URL
    fileprivate let method: Method
    
}

extension Request {
    

    
    init(base: URL,
         relativePath: String) throws {
        guard var urlComponents = URLComponents(url: base,
                                                resolvingAgainstBaseURL: true)
            else {
            throw InitError.base
        }
        urlComponents.path =  Bundle.main.urlPrefix + relativePath + "&appid=\(Bundle.main.apiKey)"
        guard let url = urlComponents.url else {
            throw InitError.relative
        }
        self.init(url: url, method: .get)
    }
    
    
}

extension Request.Method {
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
}

protocol NetworkEngine {
    
    func perform(request: Request) -> Observable<Data>
    
    func cancelAllRequets()
    
}

extension SessionManager: NetworkEngine {
    
    func perform(request: Request) -> Observable<Data> {
        return RxAlamofire.requestData(request.method.alamofireMethod,
                                       request.url)
            .map({ (_, data) -> Data in
                return data
            })
    }
    
    func cancelAllRequets() {
        self.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            let cancel: (URLSessionTask) -> Void = { (task) in
                task.cancel()
            }
            dataTasks.forEach(cancel)
            uploadTasks.forEach(cancel)
            downloadTasks.forEach(cancel)
        }
    }
    
}
