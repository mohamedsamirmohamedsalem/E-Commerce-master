
//
//  Producy.swift
//  Project
//
//  Created by Mahmoud helmy on 7/11/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//
import UIKit

struct Product : Codable {
    
    let id: Int?
    let seller_id:Int?
    let parent_id: Int?
    let sku: String?
    let url: String?
    let brand_id:Int?
    let type: String?
    let feature_set_id:Int?
    let checkav: Int?
    let position: Int?
    let is_featured: Int?
    let views: Int?
    let created_at: String?
    let updated_at: String?
    let title: String?
    let description: String?
    let short_description: String?
    let is_available: Int?
    let old_price: Int?
    let current_price: Int?
    let stock: Int?
    let feature_values : [feature]
    let main_image : [Image]
    
}

struct feature : Codable {
    let id: Int?
    let product_id: Int?
    let feature_id: Int?
    let value: String?
    let feature_name:String?
    let value_name:String?
}




struct Details : Codable {
    
    let id: Int?
    let product_id: Int?
    let description: String?
    let short_description: String?
    let title: String?
    let created_at: String?
    let updated_at: String?
    
}

struct Image : Codable {
    
    let id: Int?
    let product_id: Int?
    let image : String?
    let status : Int?
}

