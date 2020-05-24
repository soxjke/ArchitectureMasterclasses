//
//  ValidatableTextField.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/24/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import UIKit

class ValidatableTextField<ErrorType: Swift.Error> {
    struct Props {
        var error: ErrorType?
        var text: String
        let startEditing: ValueCallback<String>?
        let changedEditing: ValueCallback<String>?
        let endEditing: ValueCallback<String>?
    }
    private var props: Props = .defaultValue
    private let textField: UITextField
    private let errorLabel: UILabel
    init(textField: UITextField, errorLabel: UILabel) {
        self.textField = textField
        self.errorLabel = errorLabel
        setupObserving()
    }
    func render(props: Props) {
        self.props = props
        render()
    }
    
    private func render() {
        textField.text = props.text
        renderErrorIfAny()
    }
    
    func renderErrorIfAny() {
        guard
            let error = props.error,
            let errorText = text(for: error)
        else {
            errorLabel.isHidden = true
            return
        }
        errorLabel.isHidden = false
        errorLabel.text = errorText
    }
    
    open func text(for error: ErrorType) -> String? {
        fatalError("This method is abstract and should be overriden by subclasses")
    }
    
    private func setupObserving() {
        textField.addTarget(self, action: #selector(editingStarted(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
    }
    @objc func editingStarted(_ sender: UITextField) { props.startEditing?(textField.text ?? "") }
    @objc func editingChanged(_ sender: UITextField) { props.changedEditing?(textField.text ?? "") }
    @objc func editingEnded(_ sender: UITextField) { props.endEditing?(textField.text ?? "") }

}

extension ValidatableTextField.Props: Defaultable {
    static var defaultValue: ValidatableTextField.Props {
        return .init(error: nil,
                     text: "",
                     startEditing: nil,
                     changedEditing: nil,
                     endEditing: nil)
    }
}
