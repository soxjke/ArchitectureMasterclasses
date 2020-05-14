//
//  Validator.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

protocol Validator {
    associatedtype ErrorType: Swift.Error
    func validate(string: String) -> ErrorType?
}
