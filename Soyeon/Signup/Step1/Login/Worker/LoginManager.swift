//
//  LoginManager.swift
//  Soyeon
//
//  Created by 이재은 on 2021/03/01.
//  Copyright © 2021 ludus. All rights reserved.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

protocol LoginProtocol: AnyObject {
    func settingLogin(_ platform: Login.Platform, url: URL)
    func connect(_ platform: Login.Platform)
    func getUserInfo(_ platform: Login.Platform)
    func disconnect(_ platform: Login.Platform)
}

final class LoginManager: LoginProtocol {

    static let shared = LoginManager()

    private let kakaoAppKey = "f5a558f08033d4308bf204e88cfc866e"

    /// 플랫폼별 로그인 초기 설정
    func settingLogin(_ platform: Login.Platform, url: URL) {
        switch platform {
        case .naver:
            return
        case .kakao:
            handle(with: url)
        case .google:
            return
        case .apple:
            return
        }
    }

    /// 플랫폼별 로그인 연결
    func connect(_ platform: Login.Platform) {
        switch platform {
        case .naver:
            return
        case .kakao:
            connectKakao()
        case .google:
            return
        case .apple:
            return
        }
    }

    /// 플랫폼별 로그인 정보 가져오기
    func getUserInfo(_ platform: Login.Platform) {
        switch platform {
        case .naver:
            return
        case .kakao:
            getKakaoUserInfo()
        case .google:
            return
        case .apple:
            return
        }
    }

    /// 플랫폼별 로그인 연결 끊기
    func disconnect(_ platform: Login.Platform) {
        switch platform {
        case .naver:
            return
        case .kakao:
            disconnectKakao()
        case .google:
            return
        case .apple:
            return
        }
    }
}

extension LoginManager {

    /// 카카오 SDK 초기 설정
    func initKakaoSDK() {
        KakaoSDKCommon.initSDK(appKey: kakaoAppKey)
    }

    private func handle(with openUrl: URL) {
        if AuthApi.isKakaoTalkLoginUrl(openUrl) {
            _ = AuthController.handleOpenUrl(url: openUrl)
        }
    }

    /// 카카오 로그인 연결
    private func connectKakao() {
        // 카카오톡 설치 상태
        if AuthApi.isKakaoTalkLoginAvailable() {
            AuthApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("❌ loginWithKakaoTalk error: \(error)")
                } else {
                    print("✅ loginWithKakaoTalk success")
                    _ = oauthToken
                }
            }
        } else {
            AuthApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("❌ loginWithKakaoAccount error: \(error)")
                } else {
                    print("✅ loginWithKakaoAccount success")
                    print("oauthtoken: \(String(describing: oauthToken))")
                }
            }
        }
    }

    /// 카카오 로그인 연결 끊기
    private func disconnectKakao() {
        UserApi.shared.unlink { (error) in
            if let error = error {
                print("❌ disconnectKakao error: \(error)")
            } else {
                print("✅ unlink() success")
            }
        }
    }

    /// 카카오 로그인 사용자 정보 가져오기
    private func getKakaoUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("❌ getKakaoUserInfo() error: \(error)")
            } else {
                print("✅ me() success")
                // 회원번호 값: user.id
                // 카카오계정 프로필 정보: user.kakaoAccount.profile
                // 이메일: user.kakaoAccount.email
                _ = user
            }
        }
    }
}
