//
//  HomeResponse.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeResponse: Mappable {
    var errorFlag: Bool?
    var errorDesc: String?
    var data: [Organization]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data           <- map["Collection"]
        errorDesc      <- map["Err_Desc"]
        errorFlag      <- map["Err_Flag"]
    }
}
