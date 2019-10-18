//
//  ProfileModle.swift
//  Project
//
//  Created by Mahmoud helmy on 8/21/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import Foundation


struct profile : Codable {
    
    let id:Int?
    let name:String?
    let email:String?
    let city:String?
    let address:String?
    let phone_number:String?
    let shipping_address:String?
    let role_id:Int?
    let type:String?
    let created_at:String?
    let updated_at:String?
    let client:Client?
    let seller_info: info?
}

struct info : Codable {
    let id:Int?
    let seller_id:Int?
    let seller_type:String?
    let name:String?
    let city:String?
    let address:String?
    let phone_number:String?
    let image:String?
    let rate:Int?
}

struct Client : Codable {
    
    let id:Int?
    let user_id:Int?
    let country_id:Int?
    let region_id:Int?
    let city:String?
    let zip_code:String?
    let address:String?
    let phone_number:String?
    let image:String?
    let created_at:String?
    let updated_at:String?
}
