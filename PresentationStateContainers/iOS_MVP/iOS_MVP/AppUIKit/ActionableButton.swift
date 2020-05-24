//
//  ActionableButton.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/24/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import UIKit

class ActionableButton: UIButton {
    struct Props {
        let isEnabled: Bool
        let action: Callback
    }
    private var props: Props = .defaultValue
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupObserving()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupObserving()
    }
    
    func render(props: Props) {
        self.props = props
        render()
    }
    
    private func render() {
        self.isEnabled = props.isEnabled
    }
    
    private func setupObserving() {
        self.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }
    
    @objc func didTap(_ sender: ActionableButton) {
        props.action()
    }
}

extension ActionableButton.Props: Defaultable {
    static var defaultValue: ActionableButton.Props = .init(isEnabled: false, action: {})
}
