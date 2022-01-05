//
//  RKBreadCrumbViewCell.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public class RKBreadCrumbViewCell: UICollectionViewCell {

    var setting = Setting.current
    
    public var progress: Progress = .todo { didSet { setLayout(progress) } }
    
    typealias Model = RKBreadCrumbCollection
    var model: Model? { didSet { setModel(model) } }
    
    private func setModel(_ model: Model?) {
        guard let model = model else { fatalError(#function) }
        imageView.image = model.image
        label.text = model.title
        progress = model.progress
    }
    
    private func setLayout( _ layout: Progress) {
        
        switch progress {
        case .done:
            label.isHidden = true
            imageView.tintColor = setting.doneColor
        case .inProgress:
            label.isHidden = false
            imageView.isHidden = false
            label.textColor = setting.inProgressColor
            imageView.tintColor = setting.inProgressColor
        case .todo:
            imageView.isHidden = true
            label.textColor = setting.todoColor
        case .fail:
            label.textColor = setting.failColor
            imageView.tintColor = setting.failColor
        case .warning:
            label.textColor = setting.warningColor
            imageView.tintColor = setting.warningColor
        case .success:
            label.textColor = setting.doneColor
            imageView.tintColor = setting.doneColor
        }
        
        label.font = setting.font
    }
    
    private(set) lazy var chevronImageView = UIImageView(image: self.setting.chevronImage)
    private var imageView = UIImageView()
    private var label = UILabel()
    
     
    private lazy var rootStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageView, label, chevronImageView])
        stackView.axis = .horizontal
        stackView.spacing = setting.spaceBetweenImageAndLabel
        return stackView
    }()
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        chevronImageView.image = setting.chevronImage
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImageWidthConstraint = chevronImageView.widthAnchor.constraint(equalToConstant: setting.chevronImageSize)
        chevronImageWidthConstraint.priority = .required
        chevronImageWidthConstraint.isActive = true
        let chevronImageHeightConstraint = chevronImageView.heightAnchor.constraint(equalToConstant: setting.chevronImageSize)
        chevronImageHeightConstraint.priority = .init(rawValue: 999)
        chevronImageHeightConstraint.isActive = true
        
        chevronImageView.tintColor = .gray
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: setting.imageSize).isActive = true
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        contentView.addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

public extension RKBreadCrumbViewCell {
    enum Progress {
        case todo, inProgress, done, fail, warning, success
    }
}
