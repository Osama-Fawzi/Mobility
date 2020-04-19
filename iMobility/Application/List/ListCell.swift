//
//  ListCell.swift
//  iMobility
//
//  Created by Osama Fawzi on 17.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import UIKit


import RxSwift
import RxCocoa

final class ListCell: UITableViewCell {
    
    typealias ModelType = Model.Service.Item
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.titleLabel)
        
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ModelType) {
        self.titleLabel.text = model.title
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
}

