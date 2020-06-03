//
//  ViewController.swift
//  BluePocket
//
//  Created by Mateus Lopes on 19/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import UIKit
import AVKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener{
            (auth, user) in
            if let user = user {
                print("User has exists")
                self.transitionToTab()
            } else {
                print("User not exists")
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        
        setUpVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func setUpVideo() {
        //Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    @IBAction func goToSignUpTapped(_ sender: Any) {
    }
    
    @IBAction func goToLoginTapped(_ sender: Any) {
    }
    
    func  transitionToTab() {
        let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabViewController) as! UITabBarController
        
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
        
//        let storyboard = UIStoryboard(name: "rootVC", bundle: nil)
//        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBC") as! UITabBarController
//        if let vcs = tabbarVC.viewControllers{
//            let tc = vcs.first as? UINavigationController
////           let VC = nc.topViewController as? ViewController {
////
////              VC.pendingResult = pendingResult
//        }
////        self.present(tabbarVC, animated: false, completion: nil)
//    }

    }
}
