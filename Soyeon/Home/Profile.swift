//
//  ProfileViewModel.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/06/13.
//  Copyright © 2021 ludus. All rights reserved.
//

import Foundation

struct ProfileViewModel: Hashable {
    let id: Int
    let nickName: String
    let age: Int
    let height: Int
    let occupation: String
    let bio: String
}
