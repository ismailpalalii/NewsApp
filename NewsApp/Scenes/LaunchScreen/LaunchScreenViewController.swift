//
//  LaunchScreenViewController.swift
//  NewsApp
//
//  Created by İsmail Palalı on 1.09.2023.
//

import SnapKit
import Lottie
import UIKit

final class LaunchScreenViewController: BaseViewController {
    let lottieView = LottieAnimationView(name: "newsAnimations")

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        view.backgroundColor = .white

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.pushViewController(with: NewsViewController())
        }

        view.addSubview(lottieView)

        lottieView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()

            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
        }

        lottieView.loopMode = .loop
        lottieView.play()
    }
}
