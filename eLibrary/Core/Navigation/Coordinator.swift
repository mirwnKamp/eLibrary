//
//  Coordinator.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

protocol Coordinator where Self: UIViewController {
    func navigate(_ navigationItem: NavigationItem)
}

enum MainTabType: Int {
    case home = 0
}

struct NavigationItem {
    enum PageType {
        case viewControllers(viewControllers: [UIViewController])
        case viewController(viewController: UIViewController)
        case main
        case readScreen(bookData: Book)
    }
    
    enum NavigationStyle {
        case present(animated: Bool)
        case presentWithinNavigation(animated: Bool, hidesBottomBar: Bool)
        case push(animated: Bool)
        case replace(animated: Bool)
        case setInitialNavigationRootControllers(animated: Bool)
    }
    
    let page: PageType
    let navigationStyle: NavigationStyle
}

extension Coordinator {
    // swiftlint:disable:next cyclomatic_complexity
    func navigate(_ navigationItem: NavigationItem) {
        var controllerToNavigate: UIViewController!
        var controllersToInitialNavigation: [UIViewController] = []
        
        switch navigationItem.page {
        case .viewControllers(let viewControllers):
            controllersToInitialNavigation = viewControllers
        case .viewController(let viewController):
            controllerToNavigate = viewController
        case .main:
            controllerToNavigate = createHomeVC()
        case .readScreen(let bookData):
            controllerToNavigate =  ReadScreenVC(bookData: bookData)
        }
        
        if let controllerToNavigate = controllerToNavigate {
            controllersToInitialNavigation.append(controllerToNavigate)
        }
        
        DispatchQueue.main.async {
            switch navigationItem.navigationStyle {
            case .present(let animated):
                controllerToNavigate.modalPresentationStyle = .overFullScreen
                self.present(controllerToNavigate, animated: animated)
            case .presentWithinNavigation(let animated, let hidesBottomBar):
                controllerToNavigate.tabBarController?.hidesBottomBarWhenPushed = hidesBottomBar
                let navigationController = UINavigationController(rootViewController: controllerToNavigate)
                navigationController.isNavigationBarHidden = true
                self.present(navigationController, animated: animated)
            case .push(let animated):
                self.navigationController?.pushViewController(controllerToNavigate, animated: animated)
            case .replace(let animated):
                if var viewControllers = self.navigationController?.viewControllers {
                    viewControllers.removeLast()
                    viewControllers.append(controllerToNavigate)
                    self.navigationController?.setViewControllers(viewControllers, animated: animated)
                }
            case .setInitialNavigationRootControllers(let animated):
                Constants.appDelegate?.initialNavigationController.setViewControllers(controllersToInitialNavigation, animated: animated)
            }
        }
    }
    
    private func createHomeVC() -> UIViewController {
        let viewModel = HomeViewModel()
        let homeVC = HomeViewController()
        homeVC.output = viewModel
        viewModel.view = homeVC
        return homeVC
    }
}

