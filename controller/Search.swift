//
//  Search.swift
//  Project
//
//  Created by Mahmoud helmy on 7/6/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController {
    
    
    
    var Search = [SearchCategory]()
   
    @IBOutlet weak var SearchText: UISearchBar!
    var searching = false
    
    @IBOutlet weak var SearchResult: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Search = searchApi.GetCat(search: " ")
       // GetCat(search: " ")
        Services.instance.SearchApi(search: " " , ResultSearch: SearchResult)
        //SearchResult.reloadData()
        
        SearchResult.dataSource = self
        SearchResult.delegate = self
        SearchText.delegate = self
        

        
    }
    

    
}
    
extension SearchViewController : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // self.Item = searchedProduct.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
//        self.Item = Search.filter({(($0.p_title?.contains(searchText.lowercased()))!)})
//        searching = true
//        print(Item)
        
        Services.instance.SearchApi(search: searchText.lowercased(), ResultSearch: SearchResult)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searching = false
        searchBar.text = ""
        searchBar.endEditing(true)
        //Services.instance.SearchApi(search: searchBar.text!, ResultSearch: SearchResult)
        SearchResult.reloadData()
    }


}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.searching {
//            return self.searchedProduct.count
//        } else {
//            return 0
//        }
        if Services.instance.arr.count == 0
        {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        } else {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        }
        return Services.instance.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchTableViewCell
//            cell.Desc.text = self.Item[indexPath.row].detail?.description
//            cell.Title.text = self.Item[indexPath.row].p_title
//        cell.Price.text = "$ \( self.Item[indexPath.row].p_price ?? 0 )"
//
        cell.Desc.text = Services.instance.arr[indexPath.row].description
        cell.Title.text = Services.instance.arr[indexPath.row].title
        cell.Price.text = "$ \( Services.instance.arr[indexPath.row].current_price ?? 0 )"
        
        
        let strImg =  (Services.instance.arr[indexPath.row].main_image?[0].image)!
        
        SetImage.setImage(ImageUrl: strImg, ImageView: cell.Img)
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}
