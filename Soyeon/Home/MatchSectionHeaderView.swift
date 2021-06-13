//
//  MatchSectionHeaderView.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/06/15.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class MatchSectionHeaderView: UICollectionReusableView {
    
    private enum Theme {
        static let titleLabelFont = Fonts.nanumSquareR.size(20.0)
        static let titleLabelTintColor = Colors.strongBlack.color()
        static let subTitleLabelFont = Fonts.nanumSquareR.size(14.0)
        static let subTitleLabelTintColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.titleLabelFont
        label.textColor = Theme.titleLabelTintColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.subTitleLabelFont
        label.textColor = Theme.subTitleLabelTintColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28.0),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
