//
//  AddTypeExpenseViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 22/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddTypeExpenseViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addTypeExpensesBT: UIButton!
    
    var uid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpElements()
        let userUID = Auth.auth().currentUser!.uid
        self.uid = userUID
        print("UID DO USUÁRIO: ------------------- \(userUID) -------------------")
        
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){

        Utilities.styleTextField(nameTextField)
        Utilities.styleFilledButton(addTypeExpensesBT)
        
    }
    
    @IBAction func addTypeButton(_ sender: Any) {
        if self.nameTextField.text!.isEmpty {
            self.createAlert(title: "Opa, algo deu errado :(", message: "Parece que você não preencheu corretamente o campo. É obrigatório preencher-lo!", titleBt: "Voltar para preencher")
        } else {
            let docData: [String: Any] = [
                "nome": self.nameTextField.text!,
                "uid": self.uid!
            ]
            print(docData)
            let db = Firestore.firestore()
            db.collection("users").document(self.uid).collection("types_expense") .addDocument(data: docData)
            { (error) in
                if error != nil {
                    //Show error message
                    print("Erro ao adicionar novo tipo: \(error)")
                } else {
                    self.alerts()
                    self.nameTextField.text = ""
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    print("Documento adicionado")
                }
            }
        }
    }
    
    
    func createAlert(title: String, message: String, titleBt:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: titleBt, style: .default, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    func alerts() {
        let alertController = UIAlertController(title:"Adicionado com sucesso!",message:nil,preferredStyle:.alert)
        self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 8, repeats:false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }

}
