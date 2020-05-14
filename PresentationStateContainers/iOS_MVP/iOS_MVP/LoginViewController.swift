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
        let login: String
        let password: String
        let loginEditingChanged: ValueCallback<String?>
        let passwordEditingChanged: ValueCallback<String?>
        let loginAction: Callback
        
        static var defaultValue = LoginViewController.Props(login: "",
                                                            password: "",
                                                            loginEditingChanged: { _ in },
                                                            passwordEditingChanged: { _ in },
                                                            loginAction: {})
    }
    private var props: Props = Props.defaultValue
    var retainedObject: Any?
    
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBAction func loginButtonDidPress(_ sender: UIButton) { props.loginAction() }
    @IBAction func loginEditingChanged(_ sender: UITextField) { props.loginEditingChanged(loginField.text) }
    @IBAction func passwordEditingChanged(_ sender: UITextField) { props.passwordEditingChanged(passwordField.text)  }
    
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
    }
    
    private func renderLoginField() {
        self.loginField.text = props.login
    }
    
    private func renderPasswordField() {
        self.passwordField.text = props.password
    }
}
