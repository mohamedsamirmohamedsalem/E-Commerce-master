//
//  EditProfile.swift
//  Project
//
//  Created by Mahmoud helmy on 8/30/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Alamofire
import SwiftyJSON

protocol popupImage {
    func getImageUrl(Url:String)
}

class EditProfile: UIViewController {
    
    var url :String?
    
    var delegate : popupImage?
    
    var EditingProfile : profile?
    var dataImage = Data()
    var apiToken = UserDefaults.standard.object(forKey: "Api_token")
    
    
    

    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var Container: UIView! {
        
        didSet {
            
            Container.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var UserName: JVFloatLabeledTextField! {
        
        didSet {
            
            UserName.layer.cornerRadius = 20.0
        }
    }
    
    @IBOutlet weak var Email: JVFloatLabeledTextField! {
        
        didSet {
            
            Email.layer.cornerRadius = 20.0
        }
    }
    
    @IBOutlet weak var Telephone: JVFloatLabeledTextField! {
        
        didSet {
            
            Telephone.layer.cornerRadius = 20.0
        }
    }
    
    
    @IBOutlet weak var City: JVFloatLabeledTextField!{
        
        didSet {
            
            City.layer.cornerRadius = 20.0
        }
    }
    
    
    @IBOutlet weak var Address: JVFloatLabeledTextField! {
        
        didSet {
            
            Address.layer.cornerRadius = 20.0
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextField()
        
        
        UserName.text = EditingProfile?.name
        Address.text = EditingProfile?.client?.address
        City.text = EditingProfile?.client?.city
        Telephone.text = EditingProfile?.phone_number
        Email.text = EditingProfile?.email
        
        self.ProfileImage.clipsToBounds = true
        
        if let URL = Services.instance.ProfileApi?.client?.image {
    
                SetImage.setImage(ImageUrl: URL, ImageView: self.ProfileImage)
            } else {
    
                self.ProfileImage.image = UIImage(named: "user.png")
            }
    
        
        UserDefaults.standard.set(0, forKey: "count")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        if let URL = Services.instance.Profile?.client?.image {
//
//            SetImage.setImage(ImageUrl: URL, ImageView: self.ProfileImage)
//        } else {
//
//            self.ProfileImage.image = UIImage(named: "user.png")
//        }
//
    }
    

    
    @IBAction func Close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func GetImage(_ sender: Any) {
        
                let alert = UIAlertController(title: "Change Image", message: "Choose the place of Image", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Gallery", style: .default) { (Tapped) in
            
            self.showImageController(sourceType: .photoLibrary)
        }
        let action2 = UIAlertAction(title: "Camera", style: .default) { (Tapped) in
            
            self.showImageController(sourceType: .camera)
        }
                let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(action)
                alert.addAction(action2)
                alert.addAction(action3)
                self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func Submit(_ sender: Any) {
        
      print("error")
        let address = (Address.text) ?? " "
        let city = City.text ?? " "
        let telephone = Telephone.text  ?? " "
        
        UploadImage(city:city,address:address,telephone:telephone) { (result) in
            if result {

                print ("Success")
                
                Services.instance.ProfileData(apiToken: self.apiToken as! String) { (success) in
                    if success {
                        //print("yaaaraaaab")
                        var ImgUrl : String?
                        if ((Services.instance.ProfileApi?.seller_info) != nil) {

                            ImgUrl = Services.instance.ProfileApi?.seller_info?.image

                            print(ImgUrl)
                        } else if ((Services.instance.ProfileApi?.client) != nil) {
                            ImgUrl = Services.instance.ProfileApi?.client?.image
                        }
                        
                        self.delegate?.getImageUrl(Url: ImgUrl!)
                    }
                
                
                }
            } else {

                print ("false")
            }
        }
//        update(city: city, address: address, telephone: telephone) { (Success) in
//            if Success {
//
//                print("sssss")
//            } else {
//
//                print("aaaaaa")
//            }
//        }
    }
    
    func TextField() {
        
        
        if let myImage = UIImage(named:"user"){
            UserName.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter Your Name",floatingTile: "User name")
            
        }
        
        if let myImage = UIImage(named:"mail"){
            Email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter Your Email",floatingTile: "Email")
            
        }

        
        if let myImage = UIImage(named:"city"){
            City.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter Your City",floatingTile: "City")
            
        }

        if let myImage = UIImage(named:"telephone"){
            Telephone.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter phone number",floatingTile: "phone number")
            
        }

        if let myImage = UIImage(named:"home-address"){
            Address.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black, placeholder:"Enter Your Address",floatingTile: "Address")
            
        }

        
    }
    
    

}

extension EditProfile : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func showImageController (sourceType: UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            ProfileImage.image = image
            dataImage = image.jpegData(compressionQuality: 0.3)!
            
            //dataImage = image.jpe()!
         
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func UploadImage(city:String,address:String,telephone:String, completion: @escaping ( _ success: Bool )-> Void){
        
        
        let url = "http://temp1.cloudtouch-test.com/api/update/client"
        
        let parameter = [
            "_method" : "PATCH",
            "api_token" : apiToken ,
            "country_id" : "1",
            "city" : city,
            "address" : address,
            "phone_number" : telephone
        ]
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "count") + 1, forKey: "count")
        let count = UserDefaults.standard.integer(forKey: "count")
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        let time = "\(day)\(hour)\(minute)\(second)"
        
        
        print(UserDefaults.standard.object(forKey: "Api_token"))

        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            
            form.append(self.dataImage, withName: "image", fileName: "profile\(time)", mimeType: "image/jpeg")
            for (key, value) in parameter {
                form.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key )
            }

        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: nil) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result {
                
            case .failure(let error):
                print(error)
                completion(false)
            case .success(let upload, let streamingFromDisk, let streamFileURL):
                upload.uploadProgress(closure: { (Progress) in
                    print(Progress)
                    
                })
                upload.responseJSON { response in
                    //print response.result
                    if response.result.isSuccess {
                        do {
                           
                            self.EditingProfile = try JSONDecoder().decode(profile.self, from: response.data!)
                            print(self.EditingProfile ?? "NoData")
                            completion(true)
                            
                        } catch {
                        
                                print(error)
                                completion(false)
                        }
                        
                        
                    } else {
                        
                        completion(false)
                    }
                }.resume()
                
            }
        }
    }
    

    }
    

