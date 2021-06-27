//
//  AdditionalRouter.swift
//  Soyeon
//
//  Created by 이재은 on 2021/03/08.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit

protocol AdditionalRouterProtocol {

    var viewController: AdditionalViewController? { get }

    func navigateToMatching()
}

final class AdditionalRouter {

    weak var viewController: AdditionalViewController?

    // MARK: - Initializers

    init(viewController: AdditionalViewController?) {

        self.viewController = viewController
    }
}

// MARK: - AdditionalRouterProtocol

extension AdditionalRouter: AdditionalRouterProtocol {

    // MARK: - Navigation

    func navigateToMatching() { // destination 추후 변경
        let storyboard = UIStoryboard(name: "Additional", bundle: .main)
        if let destinationVC = storyboard
            .instantiateViewController(withIdentifier: "AdditionalViewController") as? AdditionalViewController {
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
