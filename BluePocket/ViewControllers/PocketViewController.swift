//
//  PocketViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 20/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class PocketViewController: UIViewController {

    @IBOutlet weak var revenueView: UIView!
    @IBOutlet weak var expenseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get user UID
        let userUID = Auth.auth().currentUser!.uid
        print("UID DO USUÁRIO: ------------------- \(userUID) -------------------")

        // Do any additional setup after loading the view.
       navigationController?.navigationBar.prefersLargeTitles = true
       let appearance = UINavigationBarAppearance()
       appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    @IBAction func logoutAccount(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        try? Auth.auth().signOut()
        
        let navigationController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.navigationController) as? UINavigationController
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func unwindFromDetails(segue: UIStoryboardSegue){
        
    }
}


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

