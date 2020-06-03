//
//  SignUpViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 19/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameEditText: UITextField!
    @IBOutlet weak var sobrenomeEditText: UITextField!
    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var passwordEditText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    func setUpElements(){
        //hide error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(nameEditText)
        Utilities.styleTextField(sobrenomeEditText)
        Utilities.styleTextField(emailEditText)
        Utilities.styleTextField(passwordEditText)
        Utilities.styleFilledButton(signUpButton)
        
    }

    func validateFields() -> String? {
        
        //Chack the all fields are filled in
        if nameEditText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            sobrenomeEditText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailEditText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordEditText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "É necessário preencher todos os campos"
        }
        
        //Check if the Password is Secure
        let cleanedPassword = passwordEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isnt sercure
            return "Opa, tenha certeza de que você criou uma senha de até 8 ou mais caracteres e que não tenha números e caracteres especiais!"
        }
        
        return nil
    }

    @IBAction func signUpTappe(_ sender: Any){
        
        // Validate the fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            //create cleaned versions of data
            let name = nameEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = sobrenomeEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordEditText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, err) in

                //check for erros
                if err != nil {
                    //There was an error to creating user

                    self.showError("Erro ao criar o usuário")
                } else {
                    //Sucess to create user
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData([
                     "name": name,
                     "sobrenome": lastName,
                     "email": email,
                     "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            //Show error message
                            self.showError("Usuario não foi criado corretamente")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func  transitionToHome() {
//        let homeViewController = storyboard?.instantiateViewController(identifier:
//            Constants.Storyboard.homeViewController) as! HomeViewController
//
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
    
    }

}
