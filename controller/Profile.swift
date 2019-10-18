//
//  Profile.swift
//  Project
//
//  Created by Mahmoud helmy on 6/28/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class Profile: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    var ProfileImgUrl : String?
    
    
    @IBOutlet weak var Table1: UITableView!{
        
        didSet {
            
            Table1.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var PImg: UIImageView! {
        
        didSet {
            
        PImg.layer.cornerRadius = PImg.frame.width / 2
        }
    }
    
    let apitoken =  UserDefaults.standard.object(forKey: "Api_token") as! String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Table1.dataSource = self
        Table1.delegate = self
    
        Table1.tableFooterView = UIView()
        print("hallo")
        
        
        
        
       
        }
        
        
    


        
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        PImg.isUserInteractionEnabled = true
        PImg.addGestureRecognizer(tapGestureRecognizer)
        
        
        Services.instance.ProfileData(apiToken: apitoken) { (success) in
            if success {
                
                print("profileSuccess")
                
                self.setupApi()
                
                
            } else {
                
                print("error")
            }
            
            
            
        
    }
}
    func setupApi() {
        
        self.Name.text = Services.instance.ProfileApi?.name
        self.Email.text = Services.instance.ProfileApi?.email
        
        
        if ((Services.instance.ProfileApi?.seller_info) != nil) {
            
            self.ProfileImgUrl = Services.instance.ProfileApi?.seller_info?.image
        } else if ((Services.instance.ProfileApi?.client) != nil) {
            self.ProfileImgUrl = Services.instance.ProfileApi?.client?.image
            
            print(self.ProfileImgUrl)
        }
        
        if let url = self.ProfileImgUrl {
            
            SetImage.setImage(ImageUrl: url, ImageView: self.PImg)
        } else {
            
            self.PImg.image = UIImage(named: "user.png")
        }
    }
    
    @IBAction func EditInfo(_ sender: Any) {
        
       let ProfileVC = EditProfile()
        ProfileVC.url = self.ProfileImgUrl
        ProfileVC.EditingProfile = Services.instance.ProfileApi
        ProfileVC.modalPresentationStyle = .custom
        ProfileVC.delegate = self

        
        self.present(ProfileVC, animated: true, completion: nil)

    }
    
    var data  = profileData()
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let imageData = tappedImage.image?.pngData()
        
//        let alert = UIAlertController(title: "Warning", message: "hello", preferredStyle: .alert)
//        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
        
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "ViewImage") as? ProfileImage else { return }
        
        ViewProduct.imaging = imageData!
        
        self.present(ViewProduct, animated: true, completion: nil)

        // Your action
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.Table1
        {
            return data.Img.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ProfileCell1
//        cell.ImgIcon.image = UIImage(named: data.Img[indexPath.row])
//        cell.Title.text = data.title[indexPath.row]
       // var id : String = ""
        
        if tableView == self.Table1 {
            
             //id = "cell1"
            var frame = tableView.frame
            frame.size.height = tableView.contentSize.height
            tableView.frame = frame
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ProfileCell1
            
            cell.ImgIcon.image = UIImage(named: data.Img[indexPath.row])
            cell.Title.text = data.title[indexPath.row]
            return cell
            
           
        }
        
        
        
        return UITableViewCell()
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 75.0
    }
        
       // let cells : UITableViewCell = ([cell , cell2] as? UITableViewCell)
    }

extension Profile : popupImage {
    func getImageUrl(Url: String) {
//        SetImage.setImage(ImageUrl: Url, ImageView: PImg)
        setupApi()
    }
    
    
    
    
}
    
    
    


