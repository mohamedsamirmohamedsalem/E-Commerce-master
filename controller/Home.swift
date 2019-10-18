//
//  Home.swift
//  Project
//
//  Created by Mahmoud helmy on 6/29/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import AlamofireImage

class Home: UIViewController {
    
    var data = profileData()
    var timer = Timer()
    var counter = 0
    var Category_LB = [String]()
    let instance = Services.instance
    
    
    @IBOutlet weak var CategoriesCollection: UICollectionView!
    
    @IBOutlet weak var ImgCollection: UICollectionView!
    //@IBOutlet weak var Imgbt: rounded_button!
    
    var Img :UIImageView = UIImageView()
    
    @IBOutlet weak var ProductCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImgCollection.delegate = self
        ImgCollection.dataSource = self
        
        ProductCollection.delegate = self
        ProductCollection.dataSource = self
        
        CategoriesCollection.delegate = self
        CategoriesCollection.dataSource = self
        
        instance.PopularProduct(collection: ProductCollection)
        instance.BannerApi(collection: ImgCollection )
        
        instance.GetCategory(collection : CategoriesCollection)
        
        
        
        
        
        print(instance.categories.count)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImg), userInfo: nil, repeats: true)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    @objc func changeImg () {
        
        if instance.ImgBanner.count == 0
        {
            return
        } else {
            if counter < instance.ImgBanner.count
            {
                print(counter)
                let index = IndexPath.init(item: counter , section: 0)
                self.ImgCollection.scrollToItem(at: index , at: .centeredHorizontally, animated: true)
                self.counter += 1
                
            } else {
                
                self.counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.ImgCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
}

extension Home : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! ImgCollectionViewCell
            
            SetImage.setImage(ImageUrl: instance.ImgBanner[indexPath.row].image!, ImageView: cell.SlideImg)
            return cell
            
        }
        if collectionView.tag == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductC", for: indexPath) as! ProductCell
            
            let StrImg = instance.popular_Product[indexPath.row].main_image?[0].image
            
            SetImage.setImage(ImageUrl : StrImg! , ImageView: cell.ProductImg)
            
            cell.ProductTitle.text = ((instance.popular_Product[indexPath.row].p_title)?.components(separatedBy:        CharacterSet.decimalDigits).joined(separator: ""))
            
            cell.ProductPrice.text = "$ \(instance.popular_Product[indexPath.row].p_price ?? 0)"
            
            return cell
            
        }
        if collectionView.tag == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCell
            
            
            if ( indexPath.row == instance.categories.count - 2 )
            {
                cell.Txt.text = "see All"
                //                cell.Btn.backgroundColor = RandomColor.randomColor()
                //                cell.Btn.Shadow(color: #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4156862745, alpha: 1))
                //                cell.Btn.setImage(UIImage(named: "next-2.png"), for: .normal)
                //                cell.Btn.tag = indexPath.row
                cell.Img.image = UIImage(named: "next-2.png")
                
            }else {
                
                cell.Txt.text = instance.categories[indexPath.row].name
                SetImage.setImage(ImageUrl: instance.categories[indexPath.row].image!, ImageView: cell.Img)
                
                
            }
            
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView .tag == 1
        {
            return instance.ImgBanner.count
        }
        if collectionView.tag == 2 {
            
            return instance.popular_Product.count
        }
        if collectionView.tag == 3 {
            
            return instance.categories.count
        }
        
        return Int()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
            
        }
        if collectionView.tag == 2 {
            
            return CGSize(width: 80 , height: 120)
            
        }
        if collectionView.tag == 3 {
            
            return CGSize(width: (collectionView.frame.width / 5) + 10, height: 120)
            
        }
        
        return CGSize()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 3
        {
            var id = instance.categories[indexPath.row].id
            var name = instance.categories[indexPath.row].name
            
            if indexPath.row == 3 {
                id = instance.categories[0].id
                name = instance.categories[0].name
                
                
                
            }
            
            
            Perform(index: id! , Name : name!)
        }
        if collectionView.tag == 2
        {
            guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "SelectedProduct") as? SelectedProduct else { return }
            
            //            ViewProduct.name = instance.popular_Product[indexPath.row].p_title!
            //            ViewProduct.price = "$ \(instance.popular_Product[indexPath.row].p_price ?? 0)"
            //            ViewProduct.Img = instance.popular_Product[indexPath.row].main_image![0].image!
            ViewProduct.recommend = instance.popular_Product[indexPath.row]
            self.present(ViewProduct, animated: true, completion: nil)
        }
        
    }
    
    func Perform (index : Int , Name : String) {
        
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "AllCategories") as? AllCategories else { return }
        
        ViewProduct.Parent_ID = index
        ViewProduct.Category_label = Name
        ViewProduct.cat = instance.categories
        
        self.present(ViewProduct, animated: true, completion: nil)
    }
    
}



