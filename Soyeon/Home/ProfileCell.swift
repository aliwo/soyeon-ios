//
//  ProfileCell.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/05/25.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    
    private enum Theme {
        static let backgroundColor = UIColor.white
        static let badgeButtonBackgroundColor = Colors.soyeonPurple.color()
        static let nameLabelFont = Fonts.nanumSquareR.size(18.0)
        static let nameLabelTintColor = Colors.strongBlack.color()
        static let summaryTextFont = Fonts.nanumSquareR.size(12.0)
    }
    
    private enum ViewMetrics {
        static let containerStackSpacing: CGFloat = 20.0
        static let profileInfoStackHorizontalInset = NSDirectionalEdgeInsets(
            top: 32.0,
            leading: 4.2,
            bottom: 0.0,
            trailing: 0.0
        )
        static let profileInfoStackVerticalInset = NSDirectionalEdgeInsets(
            top: 0.0,
            leading: 12.0,
            bottom: 0.0,
            trailing: 0.0
        )
    }
    
    enum LayoutDirection {
        case horizontal
        case vertical
        
        var axis: NSLayoutConstraint.Axis {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
    
    private var layoutDirection: LayoutDirection = .horizontal {
        didSet {
            containerStackView.axis = layoutDirection.axis
            profileInfoStackView.directionalLayoutMargins = layoutDirection == .horizontal
                ? ViewMetrics.profileInfoStackHorizontalInset : ViewMetrics.profileInfoStackVerticalInset
            NSLayoutConstraint.deactivate(layoutDirection == .horizontal
                                            ? verticalConstraints : horizontalConstraints)
            NSLayoutConstraint.activate(layoutDirection == .horizontal
                                            ? horizontalConstraints : verticalConstraints)
            contentView.bringSubviewToFront(badgeButton)
        }
    }
    
    private lazy var badgeButton: UIButton = {
        let button = UIButton()
        button.setTitle("상대의 하트", for: .normal)
        button.titleLabel?.font = Fonts.nanumSquareR.size(10.0)
        button.backgroundColor = Theme.badgeButtonBackgroundColor
        button.layer.cornerRadius = 2.0
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, profileInfoStackView])
        stackView.spacing = ViewMetrics.containerStackSpacing
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, summaryTextView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12.0
        stackView.directionalLayoutMargins.top = 32.0
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.nameLabelFont
        label.tintColor = Theme.nameLabelTintColor
        return label
    }()
    
    private lazy var summaryTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.font = Theme.summaryTextFont
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(
            top: 0.0,
            left: -textView.textContainer.lineFragmentPadding,
            bottom: 0.0,
            right: -textView.textContainer.lineFragmentPadding
        )
        return textView
    }()
    
    private lazy var horizontalConstraints = [
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        profileImageView.topAnchor.constraint(equalTo: topAnchor),
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        profileImageView.widthAnchor.constraint(equalToConstant: 140.0)
    ]
    
    private lazy var verticalConstraints = [
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        profileImageView.topAnchor.constraint(equalTo: topAnchor),
        profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        profileImageView.heightAnchor.constraint(equalToConstant: 162.0)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = Theme.backgroundColor
        layer.cornerRadius = 5.0
        profileImageView.image = UIImage(named: "ryan")
        badgeButton.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(badgeButton)
        contentView.addSubview(containerStackView)
        let constraints = [
            badgeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            badgeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ] + verticalConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(layoutDirection: LayoutDirection, profileViewModel profile: ProfileViewModel) {
        self.layoutDirection = layoutDirection
        self.nameLabel.text = profile.nickName
        self.summaryTextView.text =
            """
            \(profile.age)세 / \(profile.height)cm
            \(profile.occupation)
            \(profile.bio)
            """
    }
}
