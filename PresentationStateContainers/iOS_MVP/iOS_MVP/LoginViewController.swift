//
//  LoginViewController.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    struct Props: Defaultable {
        let login: ValidatableField<LoginValidator.Error>
        let password: ValidatableField<PasswordValidator.Error>
        let loginEnabled: Bool
        let loginAction: Callback
        
        static var defaultValue = LoginViewController.Props(login: .defaultValue,
                                                            password: .defaultValue,
                                                            loginEnabled: false,
                                                            loginAction: {})
    }
    private var props: Props = Props.defaultValue
    var retainedObject: Any?
    
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var loginErrorLabel: UILabel!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBAction func loginButtonDidPress(_ sender: UIButton) { props.loginAction() }
    
    @IBAction func loginEditingStarted(_ sender: UITextField) { props.login.startEditing?(loginField.text ?? "") }
    @IBAction func passwordEditingStarted(_ sender: UITextField) { props.password.startEditing?(passwordField.text ?? "") }
    @IBAction func loginEditingChanged(_ sender: UITextField) { props.login.changedEditing?(loginField.text ?? "") }
    @IBAction func passwordEditingChanged(_ sender: UITextField) { props.password.changedEditing?(passwordField.text ?? "") }
    @IBAction func loginEditingEnded(_ sender: UITextField) { props.login.endEditing?(loginField.text ?? "") }
    @IBAction func passwordEditingEnded(_ sender: UITextField) { props.password.endEditing?(passwordField.text ?? "") }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func render(props: Props) {
        self.props = props
        if isViewLoaded { render() }
    }
    
    private func render() {
        renderLoginField()
        renderPasswordField()
        renderLoginButton()
    }
    
    private func renderLoginField() {
        loginField.text = props.login.text
        renderLoginErrorIfAny()
    }
    
    private func renderLoginErrorIfAny() {
        guard let error = props.login.error else {
            loginErrorLabel.isHidden = true
            return
        }
        loginErrorLabel.isHidden = false
        switch error {
        case .loginTooShort: loginErrorLabel.text = "Login should be 3 characters or more"
        case .loginTooLong: loginErrorLabel.text = "Login should be 20 characters or less"
        case .loginNonAscii: loginErrorLabel.text = "Login should containt only letters and numbers"
        }
    }
    
    private func renderPasswordField() {
        passwordField.text = props.password.text
        renderPasswordErrorIfAny()
    }
    
    private func renderPasswordErrorIfAny() {
        guard let error = props.password.error else {
            passwordErrorLabel.isHidden = true
            return
        }
        passwordErrorLabel.isHidden = false
        switch error {
        case .passwordTooShort: passwordErrorLabel.text = "Login should be 6 characters or more"
        case .passwordShouldContainSpecialCharactes: passwordErrorLabel.text = "Password should contain special characters like !#$#@"
        }
    }
    
    private func renderLoginButton() {
        self.loginButton.isEnabled = props.loginEnabled
    }
}
