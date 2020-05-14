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

public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) -> () -> Void) -> () -> Void {
    return { [weak owner] in
        return owner.map { f($0)() }
    }
}

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> (U) -> Void) -> (U) -> Void {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) }
    }
}

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U, V) -> Void) -> (U, V) -> Void {
    return { [weak owner] obj1, obj2 in
        return owner.map { f($0)(obj1, obj2) }
    }
}

public func weakify <T: AnyObject, R>(_ owner: T, _ f: @escaping (T) -> () -> R) -> () -> R? {
    return { [weak owner] in
        return owner.map { f($0)() }
    }
}

public func weakify <T: AnyObject, U, R>(_ owner: T, _ f: @escaping (T) -> (U) -> R) -> (U) -> R? {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) }
    }
}

public func weakify <T: AnyObject, U, V, R>(_ owner: T, _ f: @escaping (T) -> (U, V) -> R) -> (U, V) -> R? {
    return { [weak owner] obj1, obj2 in
        return owner.map { f($0)(obj1, obj2) }
    }
}

public func weakify <T: AnyObject, R>(_ owner: T, _ f: @escaping (T) -> () -> Optional<R>) -> () -> R? {
    return { [weak owner] in
        return owner.flatMap { f($0)() }
    }
}

public func weakify <T: AnyObject, U, R>(_ owner: T, _ f: @escaping (T) -> (U) -> Optional<R>) -> (U) -> R? {
    return { [weak owner] obj in
        return owner.flatMap { f($0)(obj) }
    }
}

public func weakify <T: AnyObject, U, V, R>(_ owner: T, _ f: @escaping (T) -> (U, V) -> Optional<R>) -> (U, V) -> R? {
    return { [weak owner] obj1, obj2 in
        return owner.flatMap { f($0)(obj1, obj2) }
    }
}
