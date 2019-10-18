//
//  SelectedProduct.swift
//  Project
//
//  Created by Mahmoud helmy on 7/17/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import CoreData
import FBSDKShareKit
import Cosmos


let appDelegate  = UIApplication.shared.delegate as? AppDelegate
let manageContext = appDelegate?.persistentContainer.viewContext

class SelectedProduct: UIViewController {
    
    var SelectedProduct : Product?
    var recommend : Popular_Product?
    let count = 0
    
    @IBOutlet weak var ProductAndDetails: UILabel!
    
    @IBOutlet weak var ProductBtn: rounded_button!
    @IBOutlet weak var DetailBtn: rounded_button!
    
    @IBOutlet weak var cartB: AddBadge?
    
    @IBOutlet weak var ReviewsBtn: rounded_button!
    
    var name , price , Img : String?
    
    
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var Product_Price: UILabel!
    
    @IBOutlet weak var Product_Img: UIImageView!
    
    @IBOutlet weak var rating: CosmosView!
    
    var Added = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        ProductName.text = name!.components(separatedBy:        CharacterSet.decimalDigits).joined(separator: "")
        //        Product_Price.text = price
        //        SetImage.setImage(ImageUrl: Img!, ImageView: Product_Img)
        
        rating.isHidden = true
        
        ProductAndDetails.text = SelectedProduct?.title
        
        if let p = SelectedProduct {
            
            ProductName.text = p.title
            Product_Price.text = "$ \(p.current_price!)"
            SetImage.setImage(ImageUrl: (p.main_image[0].image)!, ImageView: Product_Img)
            
            
        }
        if let r = recommend {
            
            ProductName.text = r.p_title
            Product_Price.text = "$ \(r.p_price!)"
            SetImage.setImage(ImageUrl: (r.main_image?[0].image)!, ImageView: Product_Img)
        }
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if BBB.integer(forKey: "Badge") == 0
        {
            cartB?.badge = nil
        }  else
        {
            cartB?.badge = "\(BBB.integer(forKey: "Badge"))"
        }
        
    }
    
    @IBAction func Shared(_ sender: Any) {
        
        deleteAll()
        
        
        let shareDialog = ShareDialog()
        let shareLinkContent = ShareLinkContent()
        shareDialog.mode = .native
        
        //shareLinkContent.description = content
        
        //shareDialog.description = content
        
        shareLinkContent.contentURL = URL(string: (SelectedProduct?.main_image[0].image)!)!
        
        shareDialog.delegate = self as? SharingDelegate
        shareDialog.fromViewController = self
        shareDialog.shareContent = shareLinkContent
        shareDialog.show()
        
    }
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Reviews(_ sender: Any) {
        
        ProductBtn.deselected()
        DetailBtn.deselected()
        ReviewsBtn.selectedButton()
        rating.isHidden = false
        ProductAndDetails.isHidden = true
    }
    
    @IBAction func Product(_ sender: UIButton) {
        ProductBtn.selectedButton()
        DetailBtn.deselected()
        ReviewsBtn.deselected()
        ProductAndDetails.text = SelectedProduct?.short_description
        rating.isHidden = true
        ProductAndDetails.isHidden = false

        
        
    }
    
    @IBAction func Details(_ sender: UIButton) {
        DetailBtn.selectedButton()
        ProductBtn.deselected()
        ReviewsBtn.deselected()
        ProductAndDetails.text = SelectedProduct?.title
        rating.isHidden = true
        ProductAndDetails.isHidden = false

        
        //        let activityVC = UIActivityViewController(activityItems: [Product_Img], applicationActivities: nil)
        //        activityVC.popoverPresentationController?.sourceView = self.view
        //        activityVC.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        //
        //        self.present(activityVC, animated: true, completion: nil)
        //
        //    }
        //
        //    @IBAction func Reviews(_ sender: UIButton) {
        //        ReviewsBtn.selectedButton()
        //        DetailBtn.deselected()
        //        ProductBtn.deselected()
        //
        //    }
        //
        //    @IBAction func Back(_ sender: UIButton) {
        //
        //        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func ِAddToCart(_ sender: Any) {
        
        
        if checkItem(id: (SelectedProduct?.id)!)
        {
            
            insert { (finish) in
                
                if finish {
                    
                    print("Success")
                    BBB.set(BBB.integer(forKey: "Badge") + 1, forKey: "Badge")
                    cartB?.badge = "\(BBB.integer(forKey: "Badge"))"
                }
                
            }
        } else {
            
            let alert = UIAlertController(title: "Warning", message: "This Item is already in cart", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    @IBAction func GoTCart(_ sender: Any) {
        
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "tabbar") as? TabBar else { return }
        ViewProduct.self.selectedIndex = 1
        ViewProduct.circle?.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ViewProduct.tabBar.items![1].badgeValue = nil
        BBB.set(0, forKey: "Badge")
        cartB?.badge = nil
        
        self.present(ViewProduct, animated: true, completion: nil)
        
    }
    
}

extension SelectedProduct {
    
    func deleteAll(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartData")
        
        do{
            
            let results = try managedContext.fetch(fetchRequest)
            
            
            for res in results{
                managedContext.delete(res as! NSManagedObject)
            }
            
            try managedContext.save()
            
            
        }catch{
            print(error)
        }
        
    }
    
    
    func insert(Compleion: (_ finish : Bool) -> () ) {
     
        
        let addTocart = CartData(context: manageContext!)
        
        if let p = SelectedProduct {
            
            let x = p.id!
            
            
            addTocart.product_ID = Int32(x)
            addTocart.product_title = p.title
            addTocart.product_price = Double(p.current_price!)
            let imagedata = self.Product_Img.image?.pngData()
            addTocart.image = imagedata
            addTocart.product_descrebtion = p.short_description
            addTocart.count = 1
            Compleion(true)
            do {
                
                try  manageContext!.save()
                
            } catch  {
                
                print(error)
                Compleion(false)
            }
        }
        
    }
    
    
    //        if let r = recommend {
    //
    //            let x = r.id!
    //
    //            addTocart.product_ID = Int32(x)
    //            addTocart.product_title = r.p_title
    //            addTocart.product_price = Double(r.p_price!)
    //            let imagedata = self.Product_Img.image?.pngData()
    //            addTocart.image = imagedata
    //            addTocart.product_descrebtion = r.detail?.description
    //            addTocart.count = 1
    //        }
    
    
    
    
}


func checkItem(id ID:Int)->Bool {
    
    var cart : [CartData] = []
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartData")
    
    
    do {
        cart = try manageContext!.fetch(fetchRequest) as! [CartData]
        print(cart.count)
        
        if cart.count != 0
        {
            for c in cart
            {
                //    print(c)
                let id = c.product_ID
                
                if id == ID {
                    
                    return false;
                    
                } else {
                    return true
                }
            }
        }
            
            
    }catch  {
        print(error)
    }
       
    
    return true
}
