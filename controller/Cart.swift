//
//  Cart.swift
//  Project
//
//  Created by Mahmoud helmy on 7/12/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import CoreData

class Cart: UIViewController {
    
    var data : profileData = profileData()

    @IBOutlet weak var TableCart: UITableView!
    
    var cart : [CartData] = []
    
    @IBOutlet weak var TotalLB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableCart.delegate = self
        TableCart.dataSource = self
        TableCart.tableFooterView = UIView()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItem { (get) in
            if get {
                print("dataRecived")
                TableCart.reloadData()
            }
        }
    }
    
    
    
    @IBAction func CheckOut(_ sender: Any) {
        
        guard let ViewProduct = storyboard?.instantiateViewController(withIdentifier: "post") as? postOrder else { return }
        
        present(ViewProduct, animated: true, completion: nil)
        
    }
    
    
    

}

extension Cart : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath) as! CartCell
        
        
        cell.Product_Img.image = UIImage(data: cart[indexPath.row].image!, scale: 1)
        cell.Product_Title.text = cart[indexPath.row].product_title!.components(separatedBy:        CharacterSet.decimalDigits).joined(separator: "")
        cell.Product_Des.text = cart[indexPath.row].product_descrebtion
        cell.Product_Price.text = "$ \(cart[indexPath.row].product_price)"
        cell.Count.text = "\(cart[indexPath.row].count)"
        cell.PlusC = {
            
            self.update(indexPath, true)
        }
        cell.MinusC = {
            
            self.update(indexPath, false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (Action, M) in
            self.removeItem(atIndexPath: M)
            self.getItem(Completion: { (get) in
                if get {
                    print("dataRecived")
                }
            })
            //
           tableView.deleteRows(at: [indexPath], with: .automatic)
            //tableView.reloadData()
            
        }
        delete.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        return [delete]

    }
}

extension Cart {
    
    func getItem(Completion: (_ Get : Bool) -> () ) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartData")
        
        do {
            cart = try managedContext.fetch(fetchRequest) as! [CartData]
            
            var sum : Double = 0
            
            for c in cart {
                
                
                
                sum = sum + (c.product_price * Double(c.count))
                
            }
            
            self.TotalLB.text = "$ \(sum)"
            Completion(true)
        } catch  {
            print(error)
            Completion(false)
            
            }
        
    }
    
    func removeItem(atIndexPath indexpath:IndexPath){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(cart[indexpath.row])
        var sum : Double = 0
        
        for c in cart {
            
            
            
            sum = sum + (c.product_price * Double(c.count))
            
        }
        
        self.TotalLB.text = "$ \(sum)"
        print(cart)
        
        do {
            try managedContext.save()
        } catch  {
            print(error)
        }
        
    }
    
    func update(_ indexPath:IndexPath ,_ chosen:Bool){
        
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        var count = cart[indexPath.row].count
        
        if chosen
        {
            count = count + 1
            print(cart[indexPath.row].count)
        
        } else {
            if count > 1
            {
                count = count - 1
                print(cart[indexPath.row].count)
            }


        }
        
        cart[indexPath.row].count = count

        var sum : Double = 0
        
        for c in cart {
            
            
            
            sum = sum + (c.product_price * Double(c.count))
            
        }
        
        self.TotalLB.text = "$ \(sum)"
        
        TableCart.reloadData()
        
        do {
            try manageContext.save()
        } catch  {
            print(error)
            }
        
        
    }
}
