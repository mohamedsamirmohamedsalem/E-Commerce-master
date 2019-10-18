//
//  ViewController.swift
//  Project
//
//  Created by Mahmoud helmy on 6/22/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Firebase

class ViewController: UIViewController {
    
    private let DataSource = ["Seller","Client"]
    var Item  : String?
    
    @IBOutlet weak var email: JVFloatLabeledTextField!
    @IBOutlet weak var User: JVFloatLabeledTextField!
    @IBOutlet weak var password: JVFloatLabeledTextField!
    @IBOutlet weak var TelephoneNumber: JVFloatLabeledTextField!
    
    
    @IBOutlet weak var LogUserName: JVFloatLabeledTextField!
    @IBOutlet weak var LogPassword: JVFloatLabeledTextField!
    
    
    
    @IBOutlet weak var TypeOfUser: UIPickerView!
    
    
    @IBOutlet weak var SignUpV: UIView!
    @IBOutlet weak var LoGInV: UIView!
    
    @IBOutlet weak var SignUp: rounded_button!
    
    @IBOutlet weak var SignUPSwape: UIButton!
    @IBOutlet weak var LogInSwape: UIButton!
    var Sign : Bool = false
    
    @IBOutlet var Main: UIView!
    
    let services = Services.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        TypeOfUser.delegate = self
        TypeOfUser.dataSource = self
        
        let rightSwipe = UISwipeGestureRecognizer (target: self, action: #selector(self.GetLogin(sender:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        
        
        let leftSwipe = UISwipeGestureRecognizer (target: self, action: #selector(self.GetLogin(sender:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        
        Main.addGestureRecognizer(rightSwipe)
        Main.addGestureRecognizer(leftSwipe)
        
        
        //connect textField with Extension
        defineTextField(Email: email, Password: password, user: User, LoguserName: LogUserName, LoguserPassword: LogPassword, telephone: TelephoneNumber)
       
        
        
       
        showSignUp()
        //UserDefaults.standard.removeObject(forKey: "Api_token")
       
        
        Item = DataSource[0]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func GetLogin(_ sender: Any) {
        
        showLogIn()
    }
    
    @IBAction func GetSignUp(_ sender: Any) {
        
        showSignUp()
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        
        guard let mail = email.text else { return}
        guard let password = password.text else { return}
        guard let user = User.text else { return}
        guard let phone = TelephoneNumber.text else {return}
        
        
        services.Register(Email: mail, Phone: phone, Name: user, Type: Item!, Password: password){ (Success)  in
            
            if Success {
                if self.services.register?.status == 1 {
                    
                    self.services.Login(Email: mail, Password: password) { (success) in
                        if success {
                            if self.services.log?.status == 1 {
                                
                                UserDefaults.standard.set(self.services.log?.api_token, forKey: "Api_token")
                                self.performSegue(withIdentifier: "go", sender: nil)
                                BBB.set(0, forKey: "Badge")
                                
                            }else {
                                
                                self.alert((self.services.log?.message)!)
                            }
                            
                            
                        }
                    }
                    
                    
                } else {
                    
                    self.alert((self.services.register?.message)!)
                }
                
            }
        }
        
        
        
        //fire.createUser(Email: mail, password: password, Username: user)
    }
    

    @IBAction func Login(_ sender: Any) {
        
        guard let mail = LogUserName.text else {return}
        
        guard let password = LogPassword.text else {
            return}
        
//        fire.Login(Email: mail, password: password) { (success) in
//            if success {
//
//                self.performSegue(withIdentifier: "go", sender: nil)
//            }
//        }
        
        services.Login(Email: mail, Password: password) { (success) in
            print(success)
            if success {
                print(self.services.log)
                if self.services.log?.status == 1 {
                    
                    UserDefaults.standard.set(self.services.log?.api_token, forKey: "Api_token")
                    self.performSegue(withIdentifier: "go", sender: nil)
                    
                }else {
                    
                    self.alert((self.services.log?.message)!)
                }
                
                
            }
        }
        
    }
    
    
    @objc func GetLogin(sender:UIGestureRecognizer)
    {
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right :
                showSignUp()
                break;
                
            case UISwipeGestureRecognizer.Direction.left :
                
                showLogIn()
                break;
                
            default:
                return
            }
        
            
        }
        
        //User.isHidden = true
       
        
    }
    
    func showSignUp (){
        
        
        self.SignUpV.isHidden = false
        self.LoGInV.isHidden = true
        SignUPSwape.alpha = 1
        LogInSwape.alpha = 0.5
        
    }
    
    func showLogIn() {
        
        self.SignUpV.isHidden = true
        self.LoGInV.isHidden = false
        SignUPSwape.alpha = 0.5
        LogInSwape.alpha = 1
        
        
    }
    
    func alert(_ Message:String){
        
        let alert = UIAlertController(title: "Warning", message: Message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    
}


extension ViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Item = DataSource[row]
    }
    
    
}
       






