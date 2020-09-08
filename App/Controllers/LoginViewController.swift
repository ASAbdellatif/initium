//
//  LoginViewController.swift
//  App
//
//  Created by Ayman Salah on 9/8/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.returnKeyType = .next
            emailTextField.delegate = self
            emailTextField.tag = 0
        }
    }
    @IBOutlet weak var passowrdTextField: UITextField! {
        didSet {
            passowrdTextField.returnKeyType = .done
            passowrdTextField.delegate = self
            passowrdTextField.tag = 1
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.roundCorners(radius: 20.0, borderWidth: 2.0, borderColor: .white)
        loginButton.roundCorners(radius: 10.0)

    }

    @IBAction func loginAction(_ sender: Any) {
        NetworkManager.shared.login(email: emailTextField.text ?? "", password: passowrdTextField.text ?? "") { (data, errorString) in
            if let customer = data {
                Service.shared.saveUser(firstName: customer.firstName, lastName: customer.lastName)
            } else if let errorMessage = errorString {
                print("Error: -- \(errorMessage)")
            }
        }
    }
}


//MARK:- TextField

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passowrdTextField {
            textField.resignFirstResponder()
        } else {
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
               nextField.becomeFirstResponder()
            }
        }
        
        return true
    }
    
}
