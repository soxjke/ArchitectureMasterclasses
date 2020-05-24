//
//  PasswordValidatableTextField.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/24/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

class PasswordValidatableTextField: ValidatableTextField<PasswordValidator.Error> {
    override func text(for error: PasswordValidator.Error) -> String? {
        switch error {
        case .passwordTooShort: return "Password should be 6 characters or more"
        case .passwordShouldContainSpecialCharactes: return "Password should contain special characters like !#$#@"
        }
    }
}
