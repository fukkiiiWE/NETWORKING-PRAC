//
//  LoginViewController.swift
//  getImageFromServer
//
//  Created by Artur on 11.11.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var userProfile:UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
    }
    }
extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
        }
        guard AccessToken.isCurrentAccessTokenActive else {return}
        singIntoFirebase()
        
        
        print ("Successfully logged in Facebook")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("Did log out of Facebook")
    }
    
    private func openMainViewController(){
        dismiss(animated: true)
    }
    private func singIntoFirebase() {
        
        
        let accesToken = AccessToken.current
        guard let accesTokenString = accesToken?.tokenString else {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accesTokenString)
        Auth.auth().signIn(with: credentials) { user, error in
            if let error = error {
                print("Something went wrong:",error)
                return
            }
            print("Succesfully logged in with our FB user:")
            self.fetchFacebookFields()
        }
    }
    private func fetchFacebookFields(){
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start { _, result, error in
            if let error = error {
                print(error)
                return
            }
            
            if let userData = result as? [String: Any] {
                self.userProfile = UserProfile(data: userData)
                print(userData)
                print(self.userProfile?.email ?? "nil")
                self.saveIntoFirebase()
            }
        }
    }
    
    private func saveIntoFirebase(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let userData = ["name": userProfile?.name]
        
        let values = [uid: userData]
        Database.database().reference().child("users").updateChildValues(values) { error, _ in
            if let error = error {
                print(error)
                return
            }
            print ("Succesfully saved user into firebase")
            self.openMainViewController()
        }
        
    }
}
