//
//  RKBreadCrumbItemView.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public class RKBreadCrumbItemView: UIView {

    public var layout: Layout = .todo { didSet { setLayout(layout) } }
    
    private func setLayout( _ layout: Layout) {
        switch layout {
        case .done:
            UIView.animate(withDuration: Setting.animationDuration) { self.label.isHidden = true }
            imageView.tintColor = Setting.doneColor
        case .inProgress:
            label.isHidden = false
            imageView.isHidden = false
            label.textColor = Setting.inProgressColor
            imageView.tintColor = Setting.inProgressColor
        case .todo:
            imageView.isHidden = true
            label.textColor = Setting.todoColor
        }
    }
    
    private(set) var chevronImageView = UIImageView(image: Setting.chevronImage)
    private var imageView = UIImageView()
    private var label = UILabel()
    
    convenience init(image: UIImage, title: String) {
        self.init(frame: .zero)
        imageView.image = image
        label.text = title
    }
    
    private lazy var rootStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageView, label, chevronImageView])
        stackView.axis = .horizontal
        stackView.spacing = Setting.spaceBetweenImageAndLabel
        stackView.alignment = .center
        return stackView
    }()

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
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.widthAnchor.constraint(equalToConstant: Setting.chevronImageSize).isActive = true
        chevronImageView.heightAnchor.constraint(equalToConstant: Setting.chevronImageSize).isActive = true
        chevronImageView.tintColor = .gray
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: Setting.imageSize).isActive = true
    }
}

public extension RKBreadCrumbItemView {
    enum Layout {
        case todo, inProgress, done
    }
}
