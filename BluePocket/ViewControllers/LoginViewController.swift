//
//  LoginViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 19/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var passwordEditText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailEditText)
        Utilities.styleTextField(passwordEditText)
        Utilities.styleFilledButton(loginButton)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.createAlert()
                let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabViewController) as? UITabBarController
                
                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()

            }
        }
    }
    
    func createAlert() {
        let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
  
}
