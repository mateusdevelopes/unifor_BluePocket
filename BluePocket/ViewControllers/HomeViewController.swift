//
//  HomeViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 19/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
                let appearance = UINavigationBarAppearance()
        //        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        //
                navigationItem.standardAppearance = appearance
        //        navigationItem.scrollEdgeAppearance = appearance
        // Do any additional setup after loading the view.
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
