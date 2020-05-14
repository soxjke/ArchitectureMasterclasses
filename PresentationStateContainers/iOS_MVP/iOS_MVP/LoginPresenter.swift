//
//  LoginPresenter.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

class LoginPresenter {
    typealias Props = LoginViewController.Props
    weak var controller: LoginViewController?
    
    private var login: String?
    private var loginError: String? = "Login should be 3 chars or more"
    private var password: String?
    private var passwordError: String? = "Password should be 6 chars or more"
    
    init(controller: LoginViewController) {
        self.controller = controller
        present()
    }
    
    func present() {
        controller?.render(props: makeProps())
    }
    
    private func makeProps() -> Props {
        return Props(
            login: login ?? "",
            loginError: loginError,
            password: password ?? "",
            passwordError: passwordError,
            loginEditingChanged: self.loginChanged,
            passwordEditingChanged: self.passwordChanged,
            loginEnabled: loginError == nil && passwordError == nil,
            loginAction: self.loginAction
        )
    }
    
    private func loginChanged(_ string: String?) {
        login = string
        loginError = (string?.count ?? 0 < 3) ? "Login should be 3 chars or more" : nil
        present()
    }
    
    private func passwordChanged(_ string: String?) {
        password = string
        passwordError = (string?.count ?? 0 < 6) ? "Password should be 6 chars or more" : nil
        present()
    }
    
    private func loginAction() {
        // Call login method
        print("LoginPresenter now will call login with:\n\(login ?? "<no login>")\n\(password ?? "<no password>")")
    }
}
