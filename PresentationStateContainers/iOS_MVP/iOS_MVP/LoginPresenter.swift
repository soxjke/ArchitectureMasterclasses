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
    private var password: String?
    
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
            password: password ?? "",
            loginEditingChanged: self.loginChanged,
            passwordEditingChanged: self.passwordChanged,
            loginAction: self.loginAction
        )
    }
    
    private func loginChanged(_ string: String?) {
        login = string
        present()
    }
    
    private func passwordChanged(_ string: String?) {
        password = string
        present()
    }
    
    private func loginAction() {
        // Call login method
        print("LoginPresenter now will call login with:\n\(login ?? "<no login>")\n\(password ?? "<no password>")")
    }
}
