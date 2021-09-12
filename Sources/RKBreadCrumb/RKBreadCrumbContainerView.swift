//
//  RKBreadCrumbContainerView.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public protocol RKBreadCrumbContainer {
    var title: String { get }
    var image: UIImage { get }
}

class RKBreadCrumbContainerView: UIView {
    
    private var rootStackView = UIStackView()
    private(set) var breadCrumbItemView = [RKBreadCrumbItemView]()
    
    typealias Model = RKBreadCrumbContainer
    var model: [Model]? { didSet { setModel(model) } }
    var currentIndex: Int = .zero { didSet { setIndex(currentIndex) } }
    
    private func setIndex(_ index: Int) {
        guard let index = breadCrumbItemView.indices.firstIndex(of: index) else { fatalError("Invalid index") }
        for viewIndex in breadCrumbItemView.indices {
            breadCrumbItemView[viewIndex].layout = index > viewIndex ? .done : .todo
            breadCrumbItemView[viewIndex].chevronImageView.isHidden = viewIndex == breadCrumbItemView.endIndex - 1
        }
        breadCrumbItemView[index].layout = .inProgress
    }
    
    private func setModel(_ model: [Model]?) {
        guard let model = model else { fatalError(#function) }
        for item in model {
            let view = RKBreadCrumbItemView(image: item.image, title: item.title)
            breadCrumbItemView.append(view)
            rootStackView.addArrangedSubview(view)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        rootStackView.spacing = Setting.spaceBetweenItems
        rootStackView.isLayoutMarginsRelativeArrangement = true
        rootStackView.layoutMargins = .init(top: .zero, left: Setting.horizontalInset, bottom: .zero, right: Setting.horizontalInset)
    }
}
