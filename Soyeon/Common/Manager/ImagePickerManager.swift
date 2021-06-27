//
//  ImagePickerManager.swift
//  Soyeon
//
//  Created by 이재은 on 2021/06/26.
//  Copyright © 2021 ludus. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ImagePickerPresentable
protocol ImagePickerPresentable: AnyObject {
    func getSelected(_ image: UIImage)
}

extension ImagePickerPresentable where Self: UIViewController {

    /// 이미지 피커 표시
    func presentImagePickerController(_ imagePickerManager: ImagePickerManager,
                                      _ sourceType: UIImagePickerController.SourceType,
                                      _ allowsEditing: Bool) {
        imagePickerManager.delegate = self
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = imagePickerManager
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = allowsEditing
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - ImagePickerManager
final class ImagePickerManager: NSObject {

    // MARK: - Property
    weak var delegate: ImagePickerPresentable?
    
    // MARK: - Function
    private func dispose(_ imagePicker: UIImagePickerController) {
        self.delegate = nil
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dispose(picker)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var image: UIImage = UIImage()
        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            image = originalImage
        }
        self.delegate?.getSelected(image)
        dispose(picker)
    }
}
