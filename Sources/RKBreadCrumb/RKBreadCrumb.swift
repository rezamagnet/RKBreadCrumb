//
//  RKBreadCrumb.swift
//  
//
//  Created by Reza Khonsari on 11/12/21.
//

import UIKit

public struct RKBreadCrumb {
    
    public init(title: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
    
    var title: String
    var image: UIImage?
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
