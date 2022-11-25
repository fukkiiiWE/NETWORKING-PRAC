//
//  UserProfileViewController.swift
//  getImageFromServer
//
//  Created by Artur on 11.11.2022.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth



class UserProfileViewController: UIViewController {
    lazy var fbLoginButton: UIButton = {
        
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: view.frame.height - 172, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get {
            return .lightContent
        }
    }
    private func setupViews(){
        view.addSubview(fbLoginButton)
    }
}

extension UserProfileViewController:LoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
        }
        print ("Successfully logged in Facebook")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("Did log out of Facebook")
        openLoginViewController()
    }
    private func openLoginViewController(){
        
        do {
            try Auth.auth().signOut()
        
        

            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(loginViewController, animated: true)
                return
            }
        } catch let error {
            print("Failed to sign out with error: ", error.localizedDescription)
        }
    }
}
