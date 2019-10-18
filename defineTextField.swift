//
//  defineTextField.swift
//  Project
//
//  Created by Mahmoud helmy on 8/5/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField


func defineTextField(Email email:JVFloatLabeledTextField , Password password:JVFloatLabeledTextField ,user User:JVFloatLabeledTextField ,LoguserName LogUserName:JVFloatLabeledTextField ,LoguserPassword LogPassword:JVFloatLabeledTextField ,telephone TelephoneNumber:JVFloatLabeledTextField){
    
    
    if let myImage = UIImage(named:"mail"){
        email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter Email",floatingTile: "Email")
        
    }
    
    if let myImage = UIImage(named:"password-1"){
        password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder: "Enter password", floatingTile: "Password")
        
        
    }
    
    if let myImage = UIImage(named:"user"){
        User.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black,placeholder:"Enter User Name",floatingTile:"UserName")
        
    }
    
    if let myImage = UIImage(named:"user"){
        LogUserName.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black,placeholder:"EMAIL / USERNAME ",floatingTile:"EMAIL / USERNAME")
        
    }
    
    if let myImage = UIImage(named:"password-1"){
        LogPassword.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder: "Enter password", floatingTile: "Password")
        
        
    }
    
    if let myImage = UIImage(named:"telephone"){
        TelephoneNumber.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder: "Enter phone Number", floatingTile: "Phone Number")
        
        
    }
    
}
