//
//  ProfileCollectionViewCell.swift
//  Soyeon
//
//  Created by 이재은 on 2021/05/14.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var plusImageView: UIImageView!
    @IBOutlet private weak var photoImageView: UIImageView!

    private enum ViewMetrics {
        static let cellCornerRadius: CGFloat = 4
        static let cellBorderWidth: CGFloat = 1
    }

    private enum Theme {
        static let cellBorderColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0).cgColor
        static let cellHightlitedColor = Colors.soyeonBlue.cgColor()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        borderView.layer.borderWidth = ViewMetrics.cellBorderWidth
        borderView.layer.borderColor = Theme.cellBorderColor
        borderView.setRadius(ViewMetrics.cellCornerRadius)
    }

    // MARK: - Function
    func setProperties(index: Int, profileImage: UIImage?) {
        guard let pImage = profileImage else {
            photoImageView.isHidden = true
            if index == 0 {
                borderView.layer.borderColor = Theme.cellHightlitedColor
                registerLabel.isHidden = false
                plusImageView.isHidden = true
            } else {
                borderView.layer.borderColor = Theme.cellBorderColor
                registerLabel.isHidden = true
                plusImageView.isHidden = false
            }
            return
        }
        photoImageView.image = pImage
        photoImageView.isHidden = false
        plusImageView.isHidden = true
        borderView.layer.borderColor = Theme.cellHightlitedColor
    }
}
