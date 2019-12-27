//
//  LoginViewController.swift
//  Cards Contacts
//
//  Created by Nicholas Arduini on 6/23/19.
//  Copyright © 2019 Nicholas Arduini. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
        
    override func viewDidLayoutSubviews() {
        self.setupView()
    }
    
    func setupView() {
        //set underline for email and password textfields
        emailTextField.makeTextFieldUnderline()
        passwordTextField.makeTextFieldUnderline()
        
        loginButton.makeRounded()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            AuthService(self).signIn(email: email, password: password) {
                self.performSegue(withIdentifier: Constants.LOGIN_TO_TAB_SEGUE, sender: self)
            }
        }
    }
}