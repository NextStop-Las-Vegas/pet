//
//  ViewController.swift
//  Pet-prjct
//
//  Created by Pavel on 01.03.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        backBtn.tintColor = .black
        navigationItem.backBarButtonItem = backBtn
        
        //        guard (storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController) != nil else{return}
        //        Auth.auth().addIDTokenDidChangeListener ({ [weak self] (auth, user) in
        //            if user != nil {
        //                self?.navigationController?.pushViewController(homeViewController, animated: true)
        //                self?.performSegue(withIdentifier: "pushSeg", sender: nil)
        //            }
        //        })
        
                guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController else{return}
                Auth.auth().addIDTokenDidChangeListener ({ [weak self] (auth, user) in
                    if user != nil && self?.navigationController?.viewControllers.last != homeViewController {
                        self?.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                })
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

