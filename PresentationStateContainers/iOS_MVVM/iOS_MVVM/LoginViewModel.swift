//
//  LoginViewModel.swift
//  iOS_MVVM
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

class LoginViewModel {
    struct Props: Defaultable {
        var login: ValidatableField<LoginValidator.Error>
        var password: ValidatableField<PasswordValidator.Error>
        var loginEnabled: Bool
        var loginAction: Callback
        
        static var defaultValue = Props(login: .defaultValue,
                                        password: .defaultValue,
                                        loginEnabled: false,
                                        loginAction: {})
    }
    var propsDidChange: ValueCallback<Props>? {
        didSet {
            props = makeProps()
        }
    }
    private var props: Props = Props.defaultValue {
        didSet {
            propsDidChange?(makeProps())
        }
    }
    private var loginValidator = LoginValidator()
    private var passwordValidator = PasswordValidator()
    
    private func makeProps() -> Props {
        return Props(
            login: makeLoginField(),
            password: makePasswordField(),
            loginEnabled: loginValidator.validate(string: props.login.text) == nil && passwordValidator.validate(string: props.password.text) == nil,
            loginAction: weakify(self, LoginViewModel.loginAction)
        )
    }
    
    private func makeLoginField() -> ValidatableField<LoginValidator.Error> {
        return .init(error: props.login.error,
                     text: props.login.text,
                     startEditing: weakify(self, LoginViewModel.loginStartEditing),
                     changedEditing: weakify(self, LoginViewModel.loginEditingChanged),
                     endEditing: weakify(self, LoginViewModel.loginEndEditing)
                )
    }
    
    private func loginStartEditing(_ text: String) {
        props.login.error = nil
    }
    
    private func loginEditingChanged(_ text: String) {
        props.login.text = text
    }
    
    private func loginEndEditing(_ text: String) {
        props.login.error = loginValidator.validate(string: text)
    }
    
    private func makePasswordField() -> ValidatableField<PasswordValidator.Error> {
        return .init(error: props.password.error,
                     text: props.password.text,
                     startEditing: weakify(self, LoginViewModel.passwordStartEditing),
                     changedEditing: weakify(self, LoginViewModel.passwordEditingChanged),
                     endEditing: weakify(self, LoginViewModel.passwordEndEditing)
                )
    }
    
    private func passwordStartEditing(_ text: String) {
        props.password.error = nil
    }
    
    private func passwordEditingChanged(_ text: String) {
        props.password.text = text
    }
    
    private func passwordEndEditing(_ text: String) {
        props.password.error = passwordValidator.validate(string: text);
    }
            
    private func loginAction() {
        // Call login method
        print("LoginViewModel now will call login with:\n\(props.login.text)\n\(props.password.text)")
    }
}
