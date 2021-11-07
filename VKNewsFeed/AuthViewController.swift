//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 04.11.2021.
//

import UIKit


class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = AuthService()
        view.backgroundColor = .red
        
    }
    
    @IBAction func signInTouched(_ sender: Any) {
        authService.wakeUpSession()
    }
}
