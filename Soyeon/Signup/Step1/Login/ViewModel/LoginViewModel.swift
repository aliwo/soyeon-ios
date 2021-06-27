//
//  LoginViewModel.swift
//  Soyeon
//
//  Created by 이재은 on 2021/01/02.
//  Copyright (c) 2021 ludus. All rights reserved.
//

enum Login {

    enum Platform: Int, CaseIterable {
        case naver
        case kakao
        case google
        case apple

        var info: (title: String, imageName: String) {
            switch self {
            case .naver:
                return ("네이버 아이디로 시작하기", "logoNaverSignup")
            case .kakao:
                return ("카카오 아이디로 시작하기", "logoKakaoSignup")
            case .google:
                return ("구글 아이디로 시작하기", "logoGoogleSignup")
            case .apple:
                return ("Apple로 로그인", "logoAppleSignup")
            }
        }
    }

    struct LoginViewModel {
        var platforms: [Login.Platform]
    }
    
    struct ViewData: Codable {
        
    }
}
