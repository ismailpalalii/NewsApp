//
//  BaseViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import UIKit

class BaseViewController: UIViewController, BaseViewDelegate {

    // MARK: Create UI items
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        print("lifeCycleInfo viewDidLoad - \(Self.className)")
    }
}

extension BaseViewController {

    // MARK: Push View Controller
    func pushViewController(with viewController: UIViewController) {
        if let navController = self.navigationController {
            navController.pushViewController(viewController, animated: true)
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }

    func showIndicator() {
        activityIndicator.startAnimating()
    }

    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
}
