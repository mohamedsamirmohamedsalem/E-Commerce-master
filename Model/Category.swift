//
//  Category.swift
//  Project
//
//  Created by Mahmoud helmy on 7/8/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import Foundation


struct Categories : Codable {
    
    let id : Int?
    let parent_id: Int?
    let name : String?
    let is_active : Int?
    let include_in_menu: Int?
    let display_products: Int?
    let level: Int?
    let sort_order: Int?
    let created_at : String?
    let updated_at : String?
    let children_count: Int?
    let image : String?
}


