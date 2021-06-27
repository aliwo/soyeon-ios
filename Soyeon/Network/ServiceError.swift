//
//  ServiceError.swift
//  Soyeon
//
//  Created by 이재은 on 2021/02/21.
//  Copyright © 2021 ludus. All rights reserved.
//

enum ResponseError: Error {
    case failDecode
}

enum ServiceError: Int {
    case token = 401
    case notYours = 470
    case denyList = 480
}

extension ServiceError {

    var description: String {
        switch self {
        case .token:
            return "인증 토큰 오류"
        case .notYours:
            return "타인의 리소스에 접근함"
        case .denyList:
            return "정지된 계정"
        }
    }
}
