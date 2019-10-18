//
//  ProductViewController.swift
//  Project
//
//  Created by Mahmoud helmy on 7/11/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var TitleView: UIView! {
        
        didSet {
            
            TitleView.layer.shadowColor = #colorLiteral(red: 0.158003211, green: 0.1533136368, blue: 0.1531797647, alpha: 1)
            TitleView.layer.shadowOffset = CGSize(width: 0, height: 20)
            TitleView.layer.shadowRadius = 20.0
            TitleView.layer.shadowOpacity = 1.0
            
        }
    }
    @IBOutlet weak var TileLab: UILabel!
    var TitleText : String = ""
    var Category_id : Int = 0
    let instance = Services.instance
    @IBOutlet weak var ProductCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductCollection.dataSource = self
        ProductCollection.delegate = self
        
        TileLab.text = TitleText
        
        instance.GetProduct(Collection: ProductCollection, ID: Category_id)
        
      
    }
    

    @IBAction func BackBtn(_ sender: UIButton) {
        
        //ProductCollection.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    

}



extension ProductViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Services.instance.product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCell
        
        

        
        let StrImg = instance.product[indexPath.row].main_image[0].image
//        let url = URL(string: StrImg!)
//
//        do {
//
//            let data = try Data(contentsOf: url!)
//                if let image = UIImage(data: data) {
//
//
//                    cell.ProductImg.image = image
//                }
//
//
//        } catch  {
//            print(error)
//        }
        
        
        SetImage.setImage(ImageUrl : StrImg! , ImageView: cell.ProductImg)
        
        cell.ProductTitle.text = ((Services.instance.product[indexPath.row].title)?.components(separatedBy:        CharacterSet.decimalDigits).joined(separator: ""))
        
        cell.ProductPrice.text = "$ \(Services.instance.product[indexPath.row].current_price ?? 0)"
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 40) / 2 , height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "SelectedProduct") as? SelectedProduct else { return }
        
//        ViewProduct.name = instance.product[indexPath.row].p_title!
//        ViewProduct.price = "$ \(instance.product[indexPath.row].p_price ?? 0)"
//        ViewProduct.Img = instance.product[indexPath.row].main_image![0].image!
        ViewProduct.SelectedProduct = instance.product[indexPath.row]
        self.present(ViewProduct, animated: true, completion: nil)
    }

}
