//
//  ProfileImage.swift
//  Project
//
//  Created by Mahmoud helmy on 8/29/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class ProfileImage: UIViewController {

    var url : String?
    
    var imaging = Data()
    @IBOutlet weak var Image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Image.image = UIImage(data: imaging)
    }
    
    
    
    @IBAction func BackButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
  

}
