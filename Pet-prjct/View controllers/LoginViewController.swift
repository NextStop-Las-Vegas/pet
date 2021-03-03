//
//  LoginViewController.swift
//  Pet-prjct
//
//  Created by Pavel on 01.03.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: Helpers {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginButton(_ sender: UIButton) {
        
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                //self.welcomeLabel.text = error!.localizedDescription
                self.welcomeLabel.alpha = 0
                print("error")
            }
            else {
                self.welcomeLabel.alpha = 1
                print("complete")
//                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
//                self.navigationController?.pushViewController(homeViewController, animated: true)
                
            }
        }
    }
}

