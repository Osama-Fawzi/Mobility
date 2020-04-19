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
        
    @IBOutlet weak var highVal: UILabel!
    @IBOutlet weak var lowVal: UILabel!
    @IBOutlet weak var humVal: UILabel!
    @IBOutlet weak var presVal: UILabel!
    
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
                self.reloadData(data)
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
    
    private func reloadData(_ data: Weather) {
        
        highVal.text = "\(data.main.tempMax)"
        lowVal.text = "\(data.main.tempMin)"
        humVal.text = "\(data.main.humidity)"
        presVal.text = "\(data.main.pressure)"
        
    }
    
}







