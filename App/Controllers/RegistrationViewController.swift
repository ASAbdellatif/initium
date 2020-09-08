//
//  RegertrationViewController.swift
//  App
//
//  Created by Ayman Salah on 9/8/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit
import SimpleCheckbox
import SimpleTwoWayBinding

class RegistrationViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!


    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.returnKeyType = .next
            firstNameTextField.delegate = self
            firstNameTextField.tag = 0
            firstNameTextField.roundCorners(radius: 5)
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.returnKeyType = .next
            lastNameTextField.delegate = self
            lastNameTextField.tag = 1
        }
    }
    @IBOutlet weak var mobileNumberTextField: UITextField! {
        didSet {
            mobileNumberTextField.returnKeyType = .next
            mobileNumberTextField.delegate = self
            mobileNumberTextField.tag = 2
        }
    }
    
    @IBOutlet weak var civilIdTextField: UITextField! {
        didSet {
            civilIdTextField.returnKeyType = .next
            civilIdTextField.delegate = self
            civilIdTextField.tag = 3
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet {
            emailTextField.returnKeyType = .next
            emailTextField.delegate = self
            emailTextField.keyboardType = .emailAddress
            emailTextField.tag = 4
        }
    }
    
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.returnKeyType = .next
            passwordTextField.delegate = self
            passwordTextField.tag = 5
        }
    }
    @IBOutlet weak var retyprPasswordTextField: UITextField! {
        didSet {
            retyprPasswordTextField.returnKeyType = .done
            retyprPasswordTextField.delegate = self
            retyprPasswordTextField.tag = 6
        }
    }
    
    @IBOutlet weak var agreeCheckBox: UIView!
    @IBOutlet weak var completeRegistrationButton: UIButton!
    
    var model: RegistrationFormModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.roundCorners(radius: 20.0, borderWidth: 2.0, borderColor: .white)
        completeRegistrationButton.roundCorners(radius: 10.0)
//        completeRegistrationButton.isEnabled = false
        
        model = RegistrationFormModel()
        
        initCheckBox()
        setupBindings()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    
    }
    
    func initCheckBox() {
        let checkbox = Checkbox(frame: agreeCheckBox.frame)
        checkbox.valueChanged = { (value) in
            self.completeRegistrationButton.isEnabled = true
        }
        mainView.addSubview(checkbox)
        agreeCheckBox.isHidden = true
    }
    
    func setupBindings() {
        firstNameTextField.bind(with: model.firstName)
        lastNameTextField.bind(with: model.lastName)
        mobileNumberTextField.bind(with: model.mobileNo)
        civilIdTextField.bind(with: model.civilId)
        emailTextField.bind(with: model.email)
        passwordTextField.bind(with: model.password)
        retyprPasswordTextField.bind(with: model.retypePassword)
    }
    
   

 //MARK:- backend
    
    @IBAction func registrationAction(_ sender: Any) {
        NetworkManager().register(model: model) { (id, errorString) in
            if let _ = id {
                let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                    withIdentifier: "navController")
                self.drawerController?.setViewController(homeController, for: .none)
            } else if let errorMessage = errorString {
                print("Error: -- \(errorMessage)")
            }
        }
    }
    
}

//MARK:- TextField

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == retyprPasswordTextField {
            textField.resignFirstResponder()
        } else {
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
               nextField.becomeFirstResponder()
            }
        }
        
        return true
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }

    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
}
