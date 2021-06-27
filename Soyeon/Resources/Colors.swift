//
//  UIColors.swift
//  Soyeon
//
//  Created by 박은비 on 2020/12/26.
//  Copyright © 2020 ludus. All rights reserved.
//

import Foundation
import UIKit.UIColor

enum Colors: String {
    case black
    case bgNormal
    case buttonDisabled
    case darkGray
    case soyeonBlue
    case soyeonPurple
    case strongBlack
}

extension Colors {
    func color() -> UIColor {
        guard let color = UIColor(named: self.rawValue)
        else { return UIColor.white }
        
        return color
    }

    func cgColor() -> CGColor {
        guard let color = UIColor(named: self.rawValue)?.cgColor
        else { return UIColor.white.cgColor }

        return color
    }
}
