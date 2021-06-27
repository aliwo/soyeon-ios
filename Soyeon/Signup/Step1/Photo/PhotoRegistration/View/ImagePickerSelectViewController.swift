//
//  ImagePickerSelectViewController.swift
//  Soyeon
//
//  Created by 이재은 on 2021/06/06.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

protocol ImagePickerSelectVCDelegate: AnyObject {
    func selectSourceType(_ sourceType: UIImagePickerController.SourceType)
}

final class ImagePickerSelectViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var selectView: UIView!
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var albumButton: UIButton!

    // MARK: - Property
    weak var delegate: ImagePickerSelectVCDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        addTapGesture()
    }

    // MARK: - IBAction
    @IBAction private func cameraButtonDidTap(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate?.selectSourceType(.camera)
        }
    }

    @IBAction private func albumButtonDidTap(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate?.selectSourceType(.photoLibrary)
        }
    }

    // MARK: - Function
    private func setLayout() {
        selectView.layer.cornerRadius = 4
        selectView.clipsToBounds = true
    }

    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedOutside(_:)))
        selectView.superview?.isUserInteractionEnabled = true
        selectView.superview?.addGestureRecognizer(tap)
    }

    /// 뷰 외부 탭했을 때 화면 닫기 
    @objc private func didTappedOutside(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
}
