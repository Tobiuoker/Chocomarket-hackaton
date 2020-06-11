//
//  logInViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 03.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class logInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        passwordText.isSecureTextEntry = true
        emailLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        passwordLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        scrollView.keyboardDismissMode = .onDrag
        emailText.delegate = self
        passwordText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
//    func textFieldShouldReturn(textfield: UITextField) -> Bool{
//        textfield.resignFirstResponder()
//        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    @IBAction func logInButtonTapped(_ sender: Any) {
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
            
            print("zashel")
            if error != nil{
                self.errorLabel.text = "Wrong Data"
                self.errorLabel.textColor = UIColor.red
            } else {
                _ = self.navigationController?.popToRootViewController(animated: true)
                
                self.errorLabel.text = "Success"
                self.errorLabel.textColor = UIColor.green
            }
        }
    }
    
    

}
