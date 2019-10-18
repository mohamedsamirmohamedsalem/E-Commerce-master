//
//  SelectButton.swift
//  Project
//
//  Created by Mahmoud helmy on 7/17/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    func selectedButton () {
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1, green: 0.4117647059, blue: 0.4156862745, alpha: 1), for: .normal)
    }
    
    func deselected(){
        self.backgroundColor = .clear
        self.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
    }
    
    func Shadow(color : CGColor)
    {
        self.layer.shadowColor = color 
    }
}
