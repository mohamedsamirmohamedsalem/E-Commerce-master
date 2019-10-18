//
//  sign-login.swift
//  Project
//
//  Created by Mahmoud helmy on 6/25/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import Foundation
import Firebase

class fire {
    
    
        class func createUser(Email email:String , password:String , Username:String)
        {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    
                    print("error in connection" , error.localizedDescription)
                    
                }
                guard let uid = result?.user.uid else { return }
                let values = [ "email" : email , "username" : Username]
                
                Database.database().reference().child("users").child(uid).updateChildValues(values
                    , withCompletionBlock: { (error, ref) in
                        if let error = error {
                            
                            print("error in database" , error.localizedDescription)
                            
                        }
                        print("Succussfully...")
                })
                
                
            }
        
    }
    
    class func Login (Email email:String , password:String )
    {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                
                print("error in login" , error.localizedDescription)
                
            }
            
            print("Logged in.....")
        }
    }
}
