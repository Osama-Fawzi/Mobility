//
//  UIViewController+Extension.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension UIViewController {
    
    public func showAlert(with title: String,
                           message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

// UIViwController+RX
extension Reactive where Base: UIViewController {
    
    public var viewWillAppearObservable: Observable<Bool> {
        return self.sentMessage(#selector(Base.viewWillAppear(_:)))
            .map({ (animated: [Any]) -> Bool in
                return animated.first as? Bool ?? false
            })
    }
    
}


