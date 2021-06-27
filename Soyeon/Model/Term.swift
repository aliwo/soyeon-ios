//
//  Term.swift
//  Soyeon
//
//  Created by 이재은 on 2021/02/21.
//  Copyright © 2021 ludus. All rights reserved.
//

import Foundation

// MARK: - Terms

struct Terms: Codable {
    let terms: [Term]
}

// MARK: - Term

struct Term: Codable {
    let body: String
    let id: Int
    let required: Bool
    let symbol: String?
    let title: String
}
