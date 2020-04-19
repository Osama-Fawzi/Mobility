//
//  WeatherViewController.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
        
    
    let viewModel: WeatherViewModel
    var disposeBag = DisposeBag()
        
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disposeBag = DisposeBag()
        
        
        self.rx.viewWillAppearObservable
            .take(1)
            .map({ (_) -> Void in
                return
            })
            .bind(to: self.viewModel.fetchAction)
            .disposed(by: self.disposeBag)
        
        
        self.viewModel.data
            .subscribe(onNext: { [weak self] (data) in
                guard let self = self else {return}
                self.view.backgroundColor = .white
                let label = UILabel()
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textAlignment = .center
                label.numberOfLines = 0
                label.text = data.name
                
                label.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(label)
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                label.leftAnchor.constraint(lessThanOrEqualTo: self.view.leftAnchor, constant: 10).isActive = true
                label.topAnchor.constraint(lessThanOrEqualTo: self.view.topAnchor, constant: 10).isActive = true
            })
            .disposed(by: self.disposeBag)

        
        self.viewModel.error
            .subscribe(onNext: { [weak self] (error) in
                guard let self = self else {return}
                self.showAlert(with: "Error", message: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
        
        
        //Indicator
//        self.viewModel.isLoading
//            .bind(to: self.pullToRefresh.rx.isRefreshing)
//            .disposed(by: self.disposeBag)
        
    }
    
}







