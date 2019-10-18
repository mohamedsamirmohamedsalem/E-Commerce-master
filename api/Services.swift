//
//  searchApi.swift
//  Project
//
//  Created by Mahmoud helmy on 7/6/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Services {
    
    //var search = [SearchCategory]()
    
    static let instance = Services()
    var arr = [SearchCategory]()
    var ImgBanner = [Banner]()
    var categories = [Categories]()
    var popular_Product = [Popular_Product]()
    var subCategories = [Categories]()
    var product = [Product]()
    var register : RegisterUser?
    var log : LoginUser?
    var ProfileApi : profile?
    
    
    func Login(Email email : String, Password password:String, CompletionHandler: @escaping (_ success:Bool)->Void){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let url = "http://temp1.cloudtouch-test.com/api/post/login"
        let parameter = ["user_name" : email,
                         "password" : password
        ]
        
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            self.log = try JSONDecoder().decode(LoginUser.self, from: response.data!)
                            print(self.log!)
                            CompletionHandler(true)
                            
                            
                        }catch{
                            
                            print(error)
                            CompletionHandler(false)
                        }
                    }
                    
                }
                
            }.resume()
        
        
        
    }
    
    func Register(Email email : String, Phone phone : String, Name name:String ,Type type:String, Password password:String, CompletionHandler: @escaping (_ success:Bool)->Void){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let url = "http://temp1.cloudtouch-test.com/api/post/register"
        let parameter = ["email" : email,
                         "phone_number" : phone,
                         "name" : name,
                         "type" : type,
                         "password" : password
        ]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            self.register = try JSONDecoder().decode(RegisterUser.self, from: response.data!)
                            print(self.register)
                            CompletionHandler(true)
                            
                            
                        }catch{
                            
                            print(error)
                            CompletionHandler(false)
                        }
                    }
                    
                }
                
            }.resume()
        
    }
    
    
    //search
    func SearchApi(search : String, ResultSearch :UITableView){
        
        
        if (search == " " || search == "")
        {
            ResultSearch.reloadData()
            return
        }
        let URl = "http://temp1.cloudtouch-test.com/api/search?q=\(search)"
        
        let encodedUrl = URl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: encodedUrl!) else  { return  }
        
        //guard let url = URL(string: "http://eshtarey.com/api/search?q=\(search)") else { return }
        
        //let params = ["q":search]
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            self.arr = try JSONDecoder().decode([SearchCategory].self, from: response.data!)
                            ResultSearch.reloadData()
                            
                        }catch{
                            
                            print(error)
                        }
                    }
                    
                }
                
            }.resume()
        //return self.arr
        
    }
    
    func ProfileData(apiToken: String ,CompletionHandler: @escaping (_ success:Bool)->Void){
        
        
      
        let URl = "http://temp1.cloudtouch-test.com/api/profile?api_token=\(apiToken)"
        
       
        
        guard let url = URL(string: URl) else  { return  }
        
        //guard let url = URL(string: "http://eshtarey.com/api/search?q=\(search)") else { return }
        
        //let params = ["q":search]
       // let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            self.ProfileApi = try JSONDecoder().decode(profile.self, from: response.data!)
                            print(self.ProfileApi)
                            CompletionHandler(true)
                            
                        }catch{
                            
                            print(error)
                        }
                    }
                    
                }
                
            }.resume()
        //return self.arr
        
    }

    
    func BannerApi(collection : UICollectionView)  {
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        guard let url = URL(string: "http://temp1.cloudtouch-test.com/api/banners?") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            self.ImgBanner = try JSONDecoder().decode([Banner].self, from: response.data!)
                            collection.reloadData()
                            
                        } catch{
                            
                            print(error)
                        }
                    }
                }
            }.resume()
    }
    
    func GetCategory(collection : UICollectionView){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        guard let url = URL(string: "http://temp1.cloudtouch-test.com/api/categories?") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            
                            self.categories = try JSONDecoder().decode([Categories].self, from: response.data!)
                            collection.reloadData()
                            print(self.categories)
                            
                        } catch{
                            
                            print(error)
                        }
                    }
                }
            }.resume()
    }
    
    func PopularProduct(collection : UICollectionView){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        guard let url = URL(string: "http://eshtarey.com/api/popular/products") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            
                            self.popular_Product = try JSONDecoder().decode([Popular_Product].self, from: response.data!)
                            
                            collection.reloadData()
                            
                            print(self.popular_Product)
                            
                            
                        } catch{
                            
                            print(error)
                        }
                    }
                }
            }.resume()
    }
    
    func SubCategory(Table : UITableView , ID :Int){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        guard let url = URL(string: "http://temp1.cloudtouch-test.com/api/categories?pId=\(ID)") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            
                            self.subCategories = try JSONDecoder().decode([Categories].self, from: response.data!)
                            Table.reloadData()
                            
                        } catch{
                            
                            print(error)
                        }
                    }
                }
            }.resume()
    }
    
    
    
    func GetProduct(Collection : UICollectionView , ID :Int){
        
        let header = ["Content-Type":"application/json; charset=utf-8"]
        
        //        URLSession.shared.dataTask(with: url) { (data, success, error) in
        guard let url = URL(string: "http://temp1.cloudtouch-test.com/api/products/category/\(ID)?") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON
            { (response) in
                
                if response.result.isSuccess {
                    
                    DispatchQueue.main.async {
                        do
                        {
                            
                            
                            self.product = try JSONDecoder().decode([Product].self, from: response.data!)
                            print(self.product)
                            Collection.reloadData()
                            
                        } catch{
                            
                            print(error)
                        }
                    }
                }
            }.resume()
    }
}


