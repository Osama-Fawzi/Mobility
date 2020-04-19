//
//  UIViewController+Extension.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import UIKit

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
