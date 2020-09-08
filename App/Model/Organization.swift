//
//  Entity.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import ObjectMapper

struct Organization: Mappable {
    var id: String?
    var nameAr: String?
    var nameEn: String?
    var logo: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id       <- map["EmtityID"]
        nameAr   <- map["EntityArabicName"]
        nameEn   <- map["EntityEnglishName"]
        logo     <- map["EntityLogo"]
    }
}
