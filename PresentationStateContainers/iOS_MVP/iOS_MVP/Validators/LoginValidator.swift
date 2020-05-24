//
//  LoginValidator.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

class LoginValidator: Validator {
    enum Error: Swift.Error {
        case loginTooShort
        case loginTooLong
        case loginNonAscii
    }
    func validate(string: String) -> Error? {
        guard string.count >= 3 else { return .loginTooShort }
        guard string.count < 20 else { return .loginTooLong }
        guard string.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil else { return .loginNonAscii }
        return nil
    }
}
