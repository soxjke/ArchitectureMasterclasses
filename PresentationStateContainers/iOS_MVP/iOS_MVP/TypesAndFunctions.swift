//
//  TypesAndFunctions.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import Foundation

public protocol Defaultable {
    static var defaultValue: Self { get }
}

public typealias Callback = () -> ()
public typealias ValueCallback<T> = (T) -> ()
public typealias ValuesCallback<T> = ([T]) -> ()
public typealias ResultCallback<T, E: Error> = (Result<T, E>) -> ()

public typealias Future<T> = () -> T
public typealias ResultFuture<T, E: Error> = () -> Result<T, E>

public typealias InputFuture<T, R> = (T) -> R
