//
//  StorybookViewController.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import UIKit

class StorybookViewController: UITableViewController {
    var stories: [(section: String, items: [String])] = [
        (section: "LoginViewController", items: [
            "default state",
            "login error1",
            "login error2",
            "login error3",
            "password error1",
            "password error2"
        ]),
        (section: "Some non-implemented controller", items: [
            "state1",
            "state2",
            "state3"
        ]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StorybookCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        stories[section].section
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StorybookCell", for: indexPath)
        cell.textLabel?.text = stories[indexPath.section].items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
            switch indexPath.row {
            case 0: loginViewController.render(props: .init(login: .defaultValue,
                                                            password: .defaultValue,
                                                            action: .init(isEnabled: true, action: {})))
            case 1: loginViewController.render(props: .init(login: .init(error: .loginTooShort,
                                                                         text: "ab",
                                                                         startEditing: nil,
                                                                         changedEditing: nil,
                                                                         endEditing: nil),
                                                            password: .defaultValue,
                                                            action: .init(isEnabled: false, action: {})))
            case 2: loginViewController.render(props: .init(login: .init(error: .loginTooLong,
                                                                         text: "abcdefabcdefabcdefabcdef",
                                                                         startEditing: nil,
                                                                         changedEditing: nil,
                                                                         endEditing: nil),
                                                            password: .defaultValue,
                                                            action: .init(isEnabled: false, action: {})))
            case 3: loginViewController.render(props: .init(login: .init(error: .loginNonAscii,
                                                                         text: "вітаю",
                                                                         startEditing: nil,
                                                                         changedEditing: nil,
                                                                         endEditing: nil),
                                                            password: .defaultValue,
                                                            action: .init(isEnabled: false, action: {})))
            case 4: loginViewController.render(props: .init(login: .defaultValue,
                                                            password: .init(error: .passwordTooShort,
                                                                            text: "abc",
                                                                            startEditing: nil,
                                                                            changedEditing: nil,
                                                                            endEditing: nil),
                                                            action: .init(isEnabled: false, action: {})))
            case 5: loginViewController.render(props: .init(login: .defaultValue,
                                                            password: .init(error: .passwordShouldContainSpecialCharactes,
                                                                            text: "abc",
                                                                            startEditing: nil,
                                                                            changedEditing: nil,
                                                                            endEditing: nil),
                                                            action: .init(isEnabled: false, action: {})))
            default: break
            }
            navigationController?.pushViewController(loginViewController, animated: true)
        case 1: print("Some non-implemented stuff")
        default: break
        }
    }
}

