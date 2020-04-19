//
//  ListModel.swift
//  iMobility
//
//  Created by Osama Fawzi on 17.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

import RxDataSources

struct ListSection {
    
    var header: String = "section"
    var items: [Model.Service.Item]
    
}

extension Model.Service.Item: IdentifiableType {
    
    var identity: Int {
        return self.identifier
    }
    
}

extension ListSection: AnimatableSectionModelType {

    var identity: String {
        return self.header
    }
    
    init(original: ListSection, items: [Model.Service.Item]) {
        self = original
        self.items = items
    }

}
