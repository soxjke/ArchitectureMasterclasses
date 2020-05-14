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
    
    private var login: ValidatableField<LoginValidator.Error> = .defaultValue
    private var loginValidator = LoginValidator()
    private var password: ValidatableField<PasswordValidator.Error> = .defaultValue
    private var passwordValidator = PasswordValidator()
    
    init(controller: LoginViewController) {
        self.controller = controller
        present()
    }
    
    func present() {
        controller?.render(props: makeProps())
    }
    
    private func makeProps() -> Props {
        return Props(
            login: makeLoginField(),
            password: makePasswordField(),
            loginEnabled: loginValidator.validate(string: login.text) == nil && passwordValidator.validate(string: password.text) == nil,
            loginAction: self.loginAction
        )
    }
    
    private func makeLoginField() -> ValidatableField<LoginValidator.Error> {
        return .init(error: login.error,
                     text: login.text,
                     startEditing: { _ in self.login.error = nil; self.present() },
                     changedEditing: { text in self.login.text = text; self.present()  },
                     endEditing: { text in self.login.error = self.loginValidator.validate(string: text); self.present()  }
                )
    }
    
    private func makePasswordField() -> ValidatableField<PasswordValidator.Error> {
        return .init(error: password.error,
                     text: password.text,
                     startEditing: { _ in self.password.error = nil; self.present()  },
                     changedEditing: { text in self.password.text = text; self.present()  },
                     endEditing: { text in self.password.error = self.passwordValidator.validate(string: text); self.present()  }
                )
    }
            
    private func loginAction() {
        // Call login method
        print("LoginPresenter now will call login with:\n\(login.text)\n\(password.text)")
    }
}
