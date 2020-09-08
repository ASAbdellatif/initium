//
//  LoginResponse.swift
//  App
//
//  Created by Ayman Salah on 9/8/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {
    var errorFlag: Bool?
    var errorDesc: String?
    var id: String?
    var firstName: String?
    var lastName: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id             <- map["CustomerID"]
        firstName      <- map["CustomerFirstName"]
        lastName       <- map["CustomerLastName"]
        errorDesc      <- map["Err_Desc"]
        errorFlag      <- map["Err_Flag"]
    }
}
