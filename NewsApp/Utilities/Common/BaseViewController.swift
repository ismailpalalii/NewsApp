//
//  BaseViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 27.08.2023.
//

import UIKit

// MARK: BaseViewController
class BaseViewController: UIViewController, BaseViewDelegate {

    // MARK: lifeCycleInfo 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("lifeCycleInfo viewWillAppear - \(Self.className)")
    }

    override func viewDidLoad() {
       super.viewDidLoad()
       print("lifeCycleInfo viewDidLoad - \(Self.className)")
   }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("lifeCycleInfo viewDidAppear - \(Self.className)")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("lifeCycleInfo viewWillDisappear - \(Self.className)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("lifeCycleInfo viewDidDisappear - \(Self.className)")
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

    // MARK: Show Request Error PopUp
    func showRequestErrorPopUp(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Ana Sayfaya Git", style: .default) { _ in
            self.pushViewController(with: NewsViewController())
        }

        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
