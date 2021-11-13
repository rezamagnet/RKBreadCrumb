//
//  RKBreadCrumb.swift
//  
//
//  Created by Reza Khonsari on 11/12/21.
//

import UIKit

public protocol RKBreadCrumb {
    var title: String { get }
    var image: UIImage { get }
}

extension RKBreadCrumb {
    
    typealias RKBreadCrumbCollectionModel = RKBreadCrumbViewController.RKBreadCrumbCollectionModel
    
    var adapted: RKBreadCrumbCollection {
        RKBreadCrumbCollectionModel(
            title: title,
            image: image,
            progress: .inProgress
        )
    }
}
