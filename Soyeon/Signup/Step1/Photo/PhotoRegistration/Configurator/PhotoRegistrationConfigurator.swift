//
//  PhotoRegistrationConfigurator.swift
//  Soyeon
//
//  Created by 이재은 on 2021/02/07.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit

final class PhotoRegistrationConfigurator {

    // MARK: - Singleton

    static let shared: PhotoRegistrationConfigurator = PhotoRegistrationConfigurator()

    // MARK: - Configuration
    
    func configure(viewController: PhotoRegistrationViewController) {

        let router = PhotoRegistrationRouter(viewController: viewController)
        viewController.router = router
    }
}
