//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 04.11.2021.
//

import UIKit


final class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
        view.backgroundColor = #colorLiteral(red: 0.5127319694, green: 0.5525709987, blue: 1, alpha: 1)
    }
    
    @IBAction func signInTouched(_ sender: Any) {
        authService.wakeUpSession()
    }
}
