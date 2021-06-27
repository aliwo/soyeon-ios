//
//  Soyeon.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/02/11.
//  Copyright © 2021 ludus. All rights reserved.
//

import Moya
import Foundation

enum Soyeon {
    // Signup Service
    case agreeTerms(ids: [Int])
    case checkDuplicateNickname(nickname: String)
    case sms(phoneNumber: String)
    case smsAuth(key: String,
                 value: Int)
    case dryAuth(key: String,
                 value: Int)
    case googleLogin(token: String)
    case kakaoLogin(token: String)
    case naverLogin(token: String)

    // Contents Service
    case privacy
    case terms
    case lifeStyleQuestions
    case lifeStyleAnswers
    case registLifeStyle(answers: [[String: String]])
    case mbtiQuestions
    case mbtiAnswers(results: [[Int: Int]])
    case mbti(userId: String)
    
    // User Service
    case modifyUser(user: [String: String])
    case withdrawUser
    case user

}

extension Soyeon: TargetType {
    public var baseURL: URL { return URL(string: "")! }
    public var path: String {
        switch self {
        case .agreeTerms:
            return "/terms"
        case .checkDuplicateNickname(let nickname):
            return "/users/nickname/\(nickname)"
        case .sms:
            return "/sms"
        case .smsAuth:
            return "/sms/auth"
        case .dryAuth:
            return "/sms/auth/dry"
        case .googleLogin:
            return "/oauth/google"
        case .kakaoLogin:
            return "/oauth/kakao"
        case .naverLogin:
            return "/oauth/naver"
        case .privacy:
            return "/terms/privacy"
        case .terms:
            return "/terms"
        case .lifeStyleQuestions:
            return "/life_style/questions"
        case .lifeStyleAnswers:
            return "/life_style/answers"
        case .registLifeStyle:
            return "/life_style/answers"
        case .mbtiQuestions:
            return "/questions/mbti"
        case .mbtiAnswers:
            return "/questions/mbti"
        case .mbti(let userId):
            return "/results/mbti/\(userId)"
        case .modifyUser, .withdrawUser, .user:
            return "/users/me"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .agreeTerms:
            return .post
        case .checkDuplicateNickname:
            return .get
        case .sms, .smsAuth, .dryAuth:
            return .post
        case .googleLogin, .kakaoLogin, .naverLogin:
            return .post
        case .privacy:
            return .get
        case .terms:
            return .get
        case .lifeStyleQuestions:
            return .get
        case .lifeStyleAnswers:
            return .get
        case .registLifeStyle:
            return .post
        case .mbtiQuestions:
            return .get
        case .mbtiAnswers:
            return .post
        case .mbti:
            return .get
        case .modifyUser:
            return .put
        case .withdrawUser:
            return .delete
        case .user:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .agreeTerms(let ids):
            var params: [String: Any] = [:]
            params["term_ids"] = ids
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .sms(let phoneNumber):
            var params: [String: Any] = [:]
            params["phone_num"] = phoneNumber
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .smsAuth(let key, let value):
            var params: [String: Any] = [:]
            params["auth_key"] = key
            params["auth_value"] = value
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .dryAuth(let key, let value):
            var params: [String: Any] = [:]
            params["auth_key"] = key
            params["auth_value"] = value
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .googleLogin(let token), .kakaoLogin(let token), .naverLogin(let token):
            var params: [String: Any] = [:]
            params["token"] = token
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .registLifeStyle(let answers):
            let params: [String: Any] = [:]
            let jsonBody = try? JSONEncoder().encode(answers)
            return .requestCompositeData(bodyData: jsonBody ?? Data(), urlParameters: params)
        case .mbtiAnswers(let results):
            let params: [String: Any] = [:]
            let jsonBody = try? JSONEncoder().encode(results)
            return .requestCompositeData(bodyData: jsonBody ?? Data(), urlParameters: params)
        default:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        var params = [String: String]()
        params["accept"] = "application/json"
        params["Authorization"] = "Bearer 56dc2feb90b95a5f63a347ed01d938e874832274624abec6ac276abe3bb5732c"

        switch self {
        case .agreeTerms, .sms, .smsAuth, .dryAuth:
            return params
        default:
            return nil
        }
    }
}
