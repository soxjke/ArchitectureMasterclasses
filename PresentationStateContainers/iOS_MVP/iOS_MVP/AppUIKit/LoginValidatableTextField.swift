//
//  LoginValidatableTextField.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/24/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

class LoginValidatableTextField: ValidatableTextField<LoginValidator.Error> {
    override func text(for error: LoginValidator.Error) -> String? {
        switch error {
        case .loginTooShort: return "Login should be 3 characters or more"
        case .loginTooLong: return "Login should be 20 characters or less"
        case .loginNonAscii: return "Login should contain only letters and numbers"
        }
    }
}
