//
//  PhotoRegistrationRouter.swift
//  Soyeon
//
//  Created by 이재은 on 2021/02/07.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit

protocol PhotoRegistrationRouterProtocol {
    
    var viewController: PhotoRegistrationViewController? { get }
    
    func navigationToPhotoGuide() 
    func navigationToIdealType()
}

final class PhotoRegistrationRouter {
    
    weak var viewController: PhotoRegistrationViewController?
    
    // MARK: - Initializers
    
    init(viewController: PhotoRegistrationViewController?) {
        self.viewController = viewController
    }
}

// MARK: - PhotoRegistrationRouterProtocol

extension PhotoRegistrationRouter: PhotoRegistrationRouterProtocol {
    
    // MARK: - Navigation
    func navigationToPhotoGuide() {
        let storyboard = UIStoryboard(name: "PhotoGuide", bundle: .main)
        if let destinationVC = storyboard
            .instantiateViewController(withIdentifier: "PhotoGuideViewController") as? PhotoGuideViewController {
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func navigationToIdealType() {
        let storyboard = UIStoryboard(name: "Step2", bundle: .main)
        if let destinationVC = storyboard
            .instantiateViewController(withIdentifier: "IdealTypeInfoViewController") as? IdealTypeInfoViewController {
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
