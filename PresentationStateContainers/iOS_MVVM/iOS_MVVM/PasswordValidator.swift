//
//  PasswordValidator.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

class PasswordValidator: Validator {
    enum Error: Swift.Error {
        case passwordTooShort
        case passwordShouldContainSpecialCharactes
    }
    func validate(string: String) -> Error? {
        guard string.count >= 6 else { return .passwordTooShort }
        guard string.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil else { return .passwordShouldContainSpecialCharactes }
        return nil
    }
}
