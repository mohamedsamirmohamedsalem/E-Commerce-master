//
//  TextFieldExtention.swift
//  addImageToTextField
//
//  Created by Abdalla Gamal on 6/21/19.
//  Copyright © 2019 Abdalla Gamal. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField


extension JVFloatLabeledTextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor , placeholder : String , floatingTile : String){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //mainView.layer.cornerRadius = 5
        
       self.font = self.font?.withSize(20)
        self.textColor = #colorLiteral(red: 0.4823529412, green: 0.5607843137, blue: 0.5764705882, alpha: 1)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        view.backgroundColor = .clear
        view.clipsToBounds = true
//        view.layer.cornerRadius = 5
//        view.layer.borderWidth = CGFloat(0.5)
//        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: (self.frame.height / 2) - (imageView.frame.height / 2), width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
//        let seperatorView = UIView()
//        seperatorView.backgroundColor = colorSeparator
//        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            //seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: self.frame.height)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
           // seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: self.frame.height)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
//        self.layer.borderColor = colorBorder.cgColor
//        self.layer.borderWidth = CGFloat(0.5)
//        self.layer.cornerRadius = 5
        
        self.setPlaceholder(placeholder, floatingTitle: floatingTile)
        self.placeholderColor =  #colorLiteral(red: 0.4823529412, green: 0.5607843137, blue: 0.5764705882, alpha: 1)
        self.floatingLabelActiveTextColor = #colorLiteral(red: 0.4823529412, green: 0.5607843137, blue: 0.5764705882, alpha: 1)
        self.font = self.font?.withSize(15)
        
        
        
        
        
    }
    
   
    
    
}
