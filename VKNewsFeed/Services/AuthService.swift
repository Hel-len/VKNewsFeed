//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 04.11.2021.
//

import Foundation
import VK_ios_sdk

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    
    
    private let appId = "7993276"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
                print("initialized")
            case .authorized:
                print("authorized")
            default:
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
