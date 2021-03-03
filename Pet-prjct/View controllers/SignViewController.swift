//
//  SignViewController.swift
//  Pet-prjct
//
//  Created by Pavel on 01.03.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignViewController: Helpers {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController else{return}
        Auth.auth().addIDTokenDidChangeListener ({ [weak self] (auth, user) in
            if user != nil {
                self?.navigationController?.pushViewController(homeViewController, animated: true)
            }
        })
    }
    
    func setUpElements() {
        // Hide the error label
        welcomeLabel.alpha = 0
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            secondNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Заполните все поля"
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Пароль должен соcтоять из 8 символов и содержать специальные знаки"
        }
        
        return nil
    }
    
    
    @IBAction func SignButton(_ sender: UIButton) {

        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = secondNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            //            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Ошибка создания пользователя")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Ошибка при сохранении пользовательских данных")
                        }
                    }
                }
            }
        }
    }
    
    func showError(_ message:String) {
        
        welcomeLabel.text = message
        welcomeLabel.alpha = 1
    }
    
//    func transitionToHome() {
//        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
//        self.navigationController?.pushViewController(homeViewController, animated: true)
//    }
}
