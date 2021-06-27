//
//  Array+.swift
//  Soyeon
//
//  Created by 이재은 on 2021/06/05.
//  Copyright © 2021 ludus. All rights reserved.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
