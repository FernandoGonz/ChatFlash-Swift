//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Fernando González on 26/08/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        // getting the values from textFields and checking if does not nil
        if let email: String = emailTextField.text, let password: String = passwordTextField.text {
            
            // Creat new account by passing the new user's email and password
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e: Error = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: RegisterViewController.self)
                }
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

