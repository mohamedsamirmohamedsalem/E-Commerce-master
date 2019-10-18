//
//  More.swift
//  Project
//
//  Created by Mahmoud helmy on 8/30/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class More: UIViewController {
    
    
    @IBOutlet weak var LanguageImg: UIImageView!
    
    @IBOutlet weak var Language: UILabel!
    
    @IBOutlet weak var ChosenLang: UILabel!
    
    
    @IBOutlet weak var ContactUsImg: UIImageView!
    
    @IBOutlet weak var ContactUs: UILabel!
    
    
    @IBOutlet weak var AboutUsImg: UIImageView!
    
    @IBOutlet weak var AboutUs: UILabel!
    
    
    @IBOutlet weak var LangView: UIView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LanguageImg.image = UIImage(named: "language.png")
        
        ContactUsImg.image = UIImage(named: "contact-us")
        
        AboutUsImg.image = UIImage(named: "about-us")
        
        Language.text = "Language"
        ContactUs.text = "Contact Us"
        AboutUs.text = "About Us"
        
        ChosenLang.text = "English"
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewTapped(tapGestureRecognizer:)))
        LangView.isUserInteractionEnabled = true
        LangView.addGestureRecognizer(tapGestureRecognizer)

        // Do any additional setup after loading the view.
    }
    

    @objc func ViewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
                let alert = UIAlertController(title: "Change Language", message: "Choose Language", preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "English", style: .default) { (Tapped) in
        
                    self.ChosenLang.text = "English"
            }
            let action1 = UIAlertAction(title: "عربي", style: .default) { (Tapped) in
                self.ChosenLang.text = "عربي"
            }
                alert.addAction(action)
                alert.addAction(action1)
                self.present(alert, animated: true, completion: nil)
      
        
        // Your action
    }
    
    
    
    @IBAction func SignUp(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "Api_token")
         guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "Starter") as? ViewController else { return }
        
        present(ViewProduct, animated: true, completion: nil)
        
    }
    
}
