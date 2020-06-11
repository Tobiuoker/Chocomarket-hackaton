//
//  signInViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 02.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import  FirebaseDatabase

class signInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var delivererLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobilePhoneLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var delivererOrNot: UISwitch!
    
    let db = Firestore.firestore()
    let databaseRoot = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        passwordText.isSecureTextEntry = true
        
        firstNameText.delegate = self
        phoneText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        scrollView.keyboardDismissMode = .onDrag
        
        delivererLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        firstNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        mobilePhoneLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        emailLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        passwordLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)


        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            errorLabel.text = error
            errorLabel.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            
            let firstName = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var position: String = ""
            if(delivererOrNot.isOn){
                position = "deliverer"
            } else {
                position = "manager"
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//                let db = Firestore.firestore()
//                db.collection("users").addDocument(data: ["name" : firstName, "phone": phone, "email": email, "password": password, "uid": result!.user.uid, "position": position]) { (error) in
//                    if error != nil {
//                        // Show error message
//                        self.errorLabel.text = "Error saving user data"
//                    }
//                }
                
                let ref = self.databaseRoot.child("users").childByAutoId()
                
                var message:[String:String] = [:]
                
                message = ["name" : firstName, "phone": phone, "email": email, "password": password, "uid": result!.user.uid, "position": position]
                
                ref.setValue(message)
                self.errorLabel.text = "Success"
                self.errorLabel.textColor = UIColor.green
            }
        }
    }
}
