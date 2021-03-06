//
//  SignupUserDefault.swift
//  SoyeonTests
//
//  Created by 박은비 on 2021/04/04.
//  Copyright © 2021 ludus. All rights reserved.
//

import XCTest
@testable import Soyeon
 
class SignupUserDefault: XCTestCase {
    
    override func setUpWithError() throws {
        let saveTarget = Signup.step1(.agreement).resource
        
        UserDefaults.setValue(saveTarget, forKey: .saveSignUpLocation)
        
    }
  
    func testsUserDefulat() {
        if let result = UserDefaults.object(forKey: .saveSignUpLocation) as? String,
           let saveSignupLocation: Signup = Signup.initTo(path: result) {
            
            let navigation = saveSignupLocation.loadedStep
            
            let testResult = navigation.viewControllers[0] is LoginViewController &&
                             navigation.viewControllers[1] is AgreementViewController
             
             XCTAssertTrue(testResult)
        }
    }
}
  
