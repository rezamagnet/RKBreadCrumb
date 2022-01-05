//
//  RKBreadCrumbCollectionView.swift
//  
//
//  Created by Reza on 11/10/21.
//

import UIKit

public protocol RKBreadCrumbCollection {
    var title: String { get }
    var image: UIImage { get }
    var progress: RKBreadCrumbViewCell.Progress { get set }
}

class RKBreadCrumbCollectionView: UICollectionView {
    
    var setting = Setting.current
    
    typealias Model = RKBreadCrumbCollection
    var model = [Model]() { didSet { setModel(model) } }
    
    private func setModel(_ model: [Model]) {

        for item in model {
            register(RKBreadCrumbViewCell.self, forCellWithReuseIdentifier: item.title)
        }
        
        reloadData()
    }
    
    func makeCurrentInProgressFail(at indexPath: IndexPath) {
        updateCurrentProgress(.fail, indexPath: indexPath)
    }
    
    func makeCurrentInProgressWarning(at indexPath: IndexPath) {
        updateCurrentProgress(.warning, indexPath: indexPath)
    }
    
    func makeCurrentInProgressSuccess(at indexPath: IndexPath) {
        updateCurrentProgress(.success, indexPath: indexPath)
    }
    
    func makeCurrentInProgress(at indexPath: IndexPath) {
        updateCurrentProgress(.inProgress, indexPath: indexPath)
    }
    
    private func updateCurrentProgress(_ progress: RKBreadCrumbViewCell.Progress, indexPath: IndexPath) {
        guard model.indices.contains(indexPath.item) else { return }
        
        for index in model.indices {
            model[index].progress = .todo
        }
        
        
        for index in 0...indexPath.item {
            let indexPath = IndexPath(item: index, section: .zero)
            model[index].progress = .done
            
            if let cell = cellForItem(at: indexPath) as? RKBreadCrumbViewCell {
                cell.progress = .done
            }
        }
        
        model[indexPath.item].progress = progress
        
        if let cell = cellForItem(at: indexPath) as? RKBreadCrumbViewCell {
            cell.progress = progress
        }
        
        
        // TODO: Add animation
        performBatchUpdates {
            breadCrumbCollectionLayout.invalidateLayout()
        } completion: { _ in }
    }
    
    
    
    private let breadCrumbCollectionLayout = CollectionViewLayout()
    
    init() {
        breadCrumbCollectionLayout.minimumLineSpacing = 8
        breadCrumbCollectionLayout.scrollDirection = .horizontal
        breadCrumbCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: breadCrumbCollectionLayout)
        delegate = self
        dataSource = self
        backgroundColor = .white
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentInset = .init(top: .zero, left: setting.horizontalInset, bottom: .zero, right: setting.horizontalInset)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RKBreadCrumbCollectionView: UICollectionViewDelegate { }

extension RKBreadCrumbCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { model.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model[indexPath.item].title, for: indexPath) as! RKBreadCrumbViewCell
        cell.setting = setting
        cell.model = model[indexPath.item]
        cell.chevronImageView.isHidden = model.indices.last == indexPath.last
        return cell
    }
}

extension RKBreadCrumbCollectionView {
    class CollectionViewLayout: UICollectionViewFlowLayout {
        override var flipsHorizontallyInOppositeLayoutDirection: Bool { true }
    }
}
