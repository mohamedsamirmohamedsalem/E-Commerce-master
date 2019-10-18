//
//  productsModel.swift
//  Project
//
//  Created by Mahmoud helmy on 7/8/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import Foundation

struct Popular_Product : Codable {
    
    let id: Int?
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
    let p_title: String?
    let p_price: Int?
    let detail : P_Details?
    let main_image : [P_Image]?
    let price : P_price?
    
    
}

struct P_Details : Codable {
    
    let id: Int?
    let parent_id: Int?
    let description: String?
    let short_description: String?
    let title: String?
    let created_at: String?
    let updated_at: String?
}

struct P_Image : Codable {
    
    let id: Int?
    let parent_id: Int?
    let image : String?
    let status : Int?
    let created_at: String?
    let updated_at: String?
}

struct P_price : Codable {
    
    let id: Int?
     let product_id : Int?
     let old_price : Int?
     let new_price : Int?
     let stock : Int?
     let is_available : Int?
     let created_at: String?
     let updated_at: String?
}


