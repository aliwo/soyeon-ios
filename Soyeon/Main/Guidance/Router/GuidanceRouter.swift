//
//  GuidanceRouter.swift
//  Soyeon
//
//  Created by 이재은 on 2020/12/25.
//  Copyright (c) 2020 ludus. All rights reserved.
//

import UIKit

protocol GuidanceRouterProtocol {

    var viewController: GuidanceViewController? { get }

    func navigateToGuidance()
}

final class GuidanceRouter {

    weak var viewController: GuidanceViewController?

    // MARK: - Initializers
    init(viewController: GuidanceViewController?) {
        self.viewController = viewController
    }
}

// MARK: - GuidanceRouterProtocol

extension GuidanceRouter: GuidanceRouterProtocol {

    // MARK: - Navigation

    func navigateToGuidance() { // destination 추후 변경
        let storyboard = UIStoryboard(name: "Guidance", bundle: .main)
        if let destinationVC = storyboard
            .instantiateViewController(withIdentifier: "GuidanceViewController") as? GuidanceViewController {
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
