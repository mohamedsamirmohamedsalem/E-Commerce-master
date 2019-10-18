//
//  AllCategories.swift
//  Project
//
//  Created by Mahmoud helmy on 7/2/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class AllCategories: UIViewController {
    
    var data = profileData()
    var cat = [Categories]()
    var Category_label : String = ""
    
    
    @IBOutlet weak var CategoryName: UILabel!
    
    var Parent_ID : Int = 0
    @IBOutlet weak var BtnCollection: UICollectionView!
    
    @IBOutlet weak var ProductTable: UITableView! {
        
        didSet {
            
            ProductTable.layer.cornerRadius = 15.0
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ProductTable.dataSource = self
        ProductTable.delegate = self
        
        BtnCollection.dataSource = self
        BtnCollection.delegate = self
        
        Services.instance.SubCategory(Table: ProductTable, ID: Parent_ID)
        
        
        //print(Parent_ID)
        CategoryName.text = Category_label
        print(Category_label)
        
        
        
    }
    
    @IBAction func getbtn(_ sender: Any) {
        
        Parent_ID = cat[(sender as AnyObject).tag].id!
        Services.instance.SubCategory(Table: ProductTable, ID: Parent_ID)
        Category_label = Services.instance.categories[(sender as AnyObject).tag].name!
    }
    
    @IBAction func CloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}



extension AllCategories : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCat", for: indexPath) as! CategoriesCell
        
        
        cell1.Txt.text = cat[indexPath.row].name
        
        SetImage.setImage(ImageUrl: cat[indexPath.row].image!, ImageView: cell1.Img)
        
        return cell1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.width - 10 ,height: (collectionView.frame.height / 5))
        
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Parent_ID = cat[indexPath.row].id!
        Services.instance.SubCategory(Table: ProductTable, ID: Parent_ID)
        Category_label = Services.instance.categories[indexPath.row].name!
        
        
    }
    
    
}

extension AllCategories : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "All", for: indexPath) as! Allcategoriescell
        
        
        
        cell.textLb.text = Services.instance.subCategories[indexPath.row].name
        
        
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if Services.instance.subCategories.count == 0 {
            
            CategoryName.text = "NO Item To Show"
            ProductTable.isHidden = true
        } else {
            CategoryName.text = Category_label
            ProductTable.isHidden = false
        }
        return Services.instance.subCategories.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "Product") as? ProductViewController else { return }
        
        ViewProduct.Category_id = Services.instance.subCategories[indexPath.row].id!
        ViewProduct.TitleText = Services.instance.subCategories[indexPath.row].name!
        
        self.present(ViewProduct, animated: true, completion: nil)
    }
}


