//
//  RKBreadCrumbViewController.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public class RKBreadCrumbViewController: UIViewController {
    
    private var currentControllerIndex: Int = .zero {
        didSet {
            navigationHandler(at: currentControllerIndex)
        }
    }
    
    private func navigationHandler(at index: Int) {
        scrollTo(index: currentControllerIndex)
        breadCrumbCollectionView.makeCurrentInProgress(at: currentIndexPath)
        resetNavigationBarIfNeeded()
    }
    
    var currentIndexPath: IndexPath {
        IndexPath(item: currentControllerIndex, section: .zero)
    }
    
    public var setting = Setting.current {
        didSet {
            breadCrumbCollectionView.setting = setting
        }
    }
    
    public typealias Model = RKBreadCrumb
    public var items = [Model]() {
        didSet {
            let items = items.map { $0.adapted }
            breadCrumbCollectionView.model = items
            view.layoutIfNeeded()
        }
    }
    
    private lazy var breadCrumbTopAnchor = breadCrumbCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
    
    private var breadCrumbCollectionView = RKBreadCrumbCollectionView()
    public private(set) var breadCrumbNavigationController = BreadCrumbNavigationController()
    private var lineBottomView = UIView()
    
    public func setViewControllers(_ viewControllers: [UIViewController]) {

        if breadCrumbNavigationController.viewControllers.isEmpty {
            breadCrumbNavigationController.viewControllers = viewControllers
        } else {
            assertionFailure("ViewControllers set before, please use pushViewController")
        }
    }
    
    public func pushViewController(_ controller: UIViewController, animated: Bool) {
        breadCrumbNavigationController.pushViewController(controller, animated: animated)
    }
    
    public func scrollTo(index: Int, animated: Bool = true) {
        let indexPath = IndexPath(item: index, section: .zero)
        breadCrumbCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func resetNavigationBarIfNeeded() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        breadCrumbTopAnchor.constant = .zero
    }
    
    /**
     Define this method in scrollViewDidScroll(_ scrollView: UIScrollView)
     */
    public func hideNavigationBar(onScrollView scrollView: UIScrollView) {
        if let navigationBar = navigationController?.navigationBar {
            let requiredOffset = navigationBar.frame.height + statusBarHeight
            if scrollView.contentOffset.y > requiredOffset {
                navigationController?.setNavigationBarHidden(true, animated: true)
                breadCrumbTopAnchor.constant = -(navigationBar.frame.height + statusBarHeight)
            }
            
            if scrollView.contentOffset.y < -requiredOffset {
                resetNavigationBarIfNeeded()
            }
        }
    }

    public override func loadView() {
        super.loadView()
        setupViews()
    }
    
    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let navigationBackButton = UIBarButtonItem(image: setting.backChevronImage, style: .plain, target: self, action: #selector(navigationBackButtonAction))
        navigationItem.leftBarButtonItem = navigationBackButton
    }
    
    @objc private func navigationBackButtonAction() {
        if setting.returnIndexForBackButton == currentControllerIndex {
            navigationController?.popViewController(animated: true)
        } else {
            breadCrumbNavigationController.popViewController(animated: true)
        }
    }
    
    public func makeItFail() {
        breadCrumbCollectionView.makeCurrentInProgressFail(at: currentIndexPath)
    }
    
    public func makeItWarning() {
        breadCrumbCollectionView.makeCurrentInProgressWarning(at: currentIndexPath)
    }
    
    public func makeItSuccess() {
        breadCrumbCollectionView.makeCurrentInProgressSuccess(at: currentIndexPath)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        // Add breadCrumb
        view.addSubview(breadCrumbCollectionView)
        breadCrumbCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbTopAnchor,
            breadCrumbCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breadCrumbCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breadCrumbCollectionView.heightAnchor.constraint(equalToConstant: setting.breadCrumbViewHeight)
        ])
        breadCrumbCollectionView.showsHorizontalScrollIndicator = setting.showsHorizontalScrollIndicator
        
        // Add breadCrumbBottom lineView
        view.addSubview(lineBottomView)
        lineBottomView.backgroundColor = setting.borderColor
        lineBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineBottomView.bottomAnchor.constraint(equalTo: breadCrumbCollectionView.bottomAnchor),
            lineBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineBottomView.heightAnchor.constraint(equalToConstant: setting.borderThickness)
        ])
        
        // Add breadCrumbNavigationController
        breadCrumbNavigationController.delegate = self
        breadCrumbNavigationController.setNavigationBarHidden(true, animated: false)
        addChild(breadCrumbNavigationController)
        view.addSubview(breadCrumbNavigationController.view)
        breadCrumbNavigationController.didMove(toParent: self)
        breadCrumbNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbNavigationController.view.topAnchor.constraint(equalTo: breadCrumbCollectionView.bottomAnchor),
            breadCrumbNavigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            breadCrumbNavigationController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breadCrumbNavigationController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
    }

}

extension RKBreadCrumbViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let index = navigationController.viewControllers.firstIndex(of: viewController) {
            currentControllerIndex = index
            
        }
        
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            
            coordinator.notifyWhenInteractionChanges { [weak self] context in
                guard let self = self else { return }
                if context.isCancelled {
                    self.currentControllerIndex = self.currentControllerIndex + 1
                }
            }
        }
    }
}
