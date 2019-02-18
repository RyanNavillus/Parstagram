//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Ryan Sullivan on 2/17/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "Login", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        var user = PFUser();
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "Login", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
