//
//  RegisterModel.swift
//  Project
//
//  Created by Mahmoud helmy on 8/5/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit


struct RegisterUser : Codable{
    let status:Int?
    let message:String?
    let api_token:String?
    let User:user?
    }

struct user : Codable {
    let name:String?
    let email:String?
    let phone_number:String?
    let type:String?
    let updated_at:String?
    let created_at:String?
    let id:Int?
}
