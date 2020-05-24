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
        let login: LoginValidatableTextField.Props
        let password: PasswordValidatableTextField.Props
        let action: ActionableButton.Props
        
        static var defaultValue = LoginViewController.Props(login: .defaultValue,
                                                            password: .defaultValue,
                                                            action: .defaultValue)
    }
    private var props: Props = Props.defaultValue
    var retainedObject: Any?
    
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var loginErrorLabel: UILabel!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    @IBOutlet private weak var loginButton: ActionableButton!
    
    private lazy var loginValidatableField: LoginValidatableTextField = .init(textField: self.loginField,
                                                                              errorLabel: self.loginErrorLabel)
    private lazy var passwordValidatableField: PasswordValidatableTextField = .init(textField: self.passwordField,
                                                                                    errorLabel: self.passwordErrorLabel)
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func render(props: Props) {
        self.props = props
        if isViewLoaded { render() }
    }
    
    private func render() {
        loginValidatableField.render(props: props.login)
        passwordValidatableField.render(props: props.password)
        loginButton.render(props: props.action)
    }
}
