//
//  PhotoGuideViewController.swift
//  Soyeon
//
//  Created by 이재은 on 2021/01/18.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class PhotoGuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }

    private func setLayout() {
        setNavigationTitle("사진등록 가이드")
    }
}
