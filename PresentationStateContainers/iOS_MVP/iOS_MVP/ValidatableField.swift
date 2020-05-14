//
//  ValidatableField.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

struct ValidatableField<ErrorType: Swift.Error> {
    var error: ErrorType?
    var text: String
    let startEditing: ValueCallback<String>?
    let changedEditing: ValueCallback<String>?
    let endEditing: ValueCallback<String>?
}

extension ValidatableField: Defaultable {
    static var defaultValue: ValidatableField<ErrorType> {
        return .init(error: nil,
                     text: "",
                     startEditing: nil,
                     changedEditing: nil,
                     endEditing: nil)
    }
}
