//
//  MatchSectionFooterView.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/06/26.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class MatchSectionFooterView: UICollectionReusableView {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("추가매칭 하기", for: .normal)
        button.titleEdgeInsets.left = 8.0
        button.setTitleColor(Colors.black.color(), for: .normal)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 25.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        let constraints = [
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
