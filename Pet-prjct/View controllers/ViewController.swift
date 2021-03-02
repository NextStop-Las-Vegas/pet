//
//  ViewController.swift
//  Pet-prjct
//
//  Created by Pavel on 01.03.2021.
//

import UIKit

class ViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        backBtn.tintColor = .black
        navigationItem.backBarButtonItem = backBtn
    }

    @IBAction func signUpButton(_ sender: UIButton) {
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! SignViewController
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    @IBAction func loginButton(_ sender: UIButton) {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

