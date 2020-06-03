//
//  AddNewRevenueViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 20/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CodableFirebase

class AddNewRevenueViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let datePicker = UIDatePicker()
    let typePicker = UIPickerView()
    
    var types = ["Aasd", "dsffFR", "ADWGV"]
    var userUid: String = ""
    var uid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserID()
        getTypesExpenses()
        
        setUpElements()
        createDatePicker()
        createTypePicker()
        // Do any additional setup after loading the view.
    }
    
    func getUserID() {
        let userUID = Auth.auth().currentUser!.uid
        self.uid = userUID
        print("UID DO USUÁRIO: ------------------- \(userUID) -------------------")
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(typeTextField)
        Utilities.styleTextField(dateTextField)
        Utilities.styleTextField(valueTextField)
        Utilities.styleFilledButton(doneButton)
    
    }
    
    
    func createTypePicker() {

        //assign date picker to the field
        typePicker.delegate = self
        typePicker.dataSource = self
        typeTextField.inputView = typePicker
    }
    
    func createDatePicker() {
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let okBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePressed))
        toolbar.setItems([okBtn], animated: true)
        
        //assign toolbar
        dateTextField.inputAccessoryView = toolbar
        
        //assign date picker to the field
        dateTextField.inputView = datePicker
    }
    
    @objc func doneDatePressed(){
        //formatter
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        
        dateTextField.text = formater.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = types[row]
        typeTextField.resignFirstResponder()
    }
    
    @IBAction func addNewRevenue(_ sender: Any) {
        if self.nameTextField.text!.isEmpty || self.typeTextField.text!.isEmpty || self.dateTextField.text!.isEmpty || self.valueTextField.text!.isEmpty {
            
            self.createAlert(title: "Opa, algo deu errado :(", message: "Parece que você não preencheu corretamente os campos. É obrigatório preencher-los!", titleBt: "Voltar para preencher")
        } else {
            let docData: [String: Any] = [
                "nome": self.nameTextField.text!,
                "tipo": self.typeTextField.text!,
                "data": self.dateTextField.text!,
                "valor": self.valueTextField.text!,
                "uid": self.uid!
            ]
            print(docData)
            let db = Firestore.firestore()
            db.collection("users").document(self.uid).collection("revenues") .addDocument(data: docData)
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
    
    func getTypesExpenses() {
//        let model: FTypeExpenseModel
//        let docData = try! FirestoreEncoder().encode(model)
//        let db = Firestore.firestore()
//        db.collection("users").document(self.uid).collection("types_expense").getDocuments() { error in
//            if let error = error {
//                print("Model: \(erro)")
//            } else {
//                print("Document não funfou ou n existe! POOOOORRRAAAAAAA!")
//            }
//
//        }
        
//            print("METODO INICIADO")
//            let db = Firestore.firestore()
//            db.collection("users").document(self.uid).collection("types_expense").getDocuments() { (querySnapshot, err) in
//                   if let err = err {
//                       print("Error getting documents: \(err)")
//                    print(
//                    "Deu MERDA")
//                   } else {
//                    print("PARECE QUE TA TUDO DE BOA")
////                        let documents = querySnapshot!.documents
////                        try! documents.forEach {
////                            document in
////                            let myTypes: FTypeExpenseModel = try document.decoded()
////                            print("IMPRIMIR OBJ \(myTypes.name)")
////                        }
//
//
//                        let myTypes: [FTypeExpenseModel] = try! querySnapshot!.decoded()
//                        myTypes.forEach({ print($0) })
//    //                   for document in querySnapshot!.documents {
//    //                    print("\(document.documentID) => \(document.data())")
//    //                    }
//                   }
//           }
        }
}
