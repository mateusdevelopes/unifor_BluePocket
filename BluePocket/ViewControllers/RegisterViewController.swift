//
//  RegisterViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 18/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneRegister(_ sender: Any) {
        if self.passwordTextField.text == self.confirmPasswordTextField.text{
            let newUser = User(context: self.appDelegate.persistentContainer.viewContext)
            newUser.name = self.fullNameTextField.text
            newUser.email = self.emailTextField.text
                newUser.senha = self.passwordTextField.text
            
            let context = self.appDelegate.persistentContainer.viewContext
                if context.hasChanges {
                    do {
                        try context.save()
                        print("User cadastrado!")
                    } catch {
                        print("Cadastrado deu Erro!")
                        context.delete(newUser)
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
