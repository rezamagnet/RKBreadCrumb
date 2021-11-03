//
//  RKBreadCrumbViewController.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public protocol RKBreadCrumb: RKBreadCrumbContainer { }

public class RKBreadCrumbViewController: UIViewController {
    
    public typealias Model = RKBreadCrumb
    public var items = [Model]() { didSet { breadCrumbContainerView.model = items; view.layoutIfNeeded() } }
    
    private lazy var breadCrumbTopAnchor = scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
    
    private var scrollView = UIScrollView()
    private var breadCrumbContainerView = RKBreadCrumbContainerView()
    private var breadCrumbNavigationController = UINavigationController()
    private var lineBottomView = UIView()
    public private(set) var currentIndex: Int = .zero
    
    public func setViewControllers(_ viewControllers: [UIViewController]) {
        guard let index = viewControllers.indices.last else { return }
        
        
        if breadCrumbNavigationController.viewControllers.isEmpty {
            breadCrumbNavigationController.viewControllers = breadCrumbNavigationController.viewControllers + viewControllers
        } else {
            if let viewController = viewControllers.last {
                DispatchQueue.main.async {
                    self.breadCrumbNavigationController.pushViewController(viewController, animated: true)                    
                }
            } else {
                // Delete all view controllers if is empty
                breadCrumbNavigationController.viewControllers = []
            }
        }
        
        breadCrumbContainerView.currentIndex = breadCrumbNavigationController.viewControllers.indices.last ?? .zero
        scrollToIndex(index)
        if navigationController?.isNavigationBarHidden == true {
            resetNavigationBarIfNeeded()
        }
    }
    
    public func scrollToIndex(_ index: Int, animated: Bool = true) {
        scrollView.scrollRectToVisible(breadCrumbContainerView.breadCrumbItemView[index].frame, animated: animated)
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
                navigationController?.setNavigationBarHidden(false, animated: true)
                breadCrumbTopAnchor.constant = .zero
            }
        }
    }

    public override func loadView() {
        super.loadView()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbTopAnchor,
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Setting.breadCrumbViewHeight)
        ])
        scrollView.showsHorizontalScrollIndicator = Setting.showsHorizontalScrollIndicator
        
        scrollView.addSubview(breadCrumbContainerView)
        breadCrumbContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            breadCrumbContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            breadCrumbContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            breadCrumbContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            breadCrumbContainerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        breadCrumbNavigationController.delegate = self
        breadCrumbNavigationController.setNavigationBarHidden(true, animated: false)
        addChild(breadCrumbNavigationController)
        view.addSubview(breadCrumbNavigationController.view)
        breadCrumbNavigationController.willMove(toParent: self)
        breadCrumbNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbNavigationController.view.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            breadCrumbNavigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            breadCrumbNavigationController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breadCrumbNavigationController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(lineBottomView)
        lineBottomView.backgroundColor = Setting.borderColor
        lineBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineBottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            lineBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineBottomView.heightAnchor.constraint(equalToConstant: Setting.borderThickness)
        ])
    }
}

extension RKBreadCrumbViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let index = navigationController.viewControllers.firstIndex(of: viewController) {
            breadCrumbContainerView.currentIndex = index
            scrollToIndex(index)
            resetNavigationBarIfNeeded()
        }
    }
}
