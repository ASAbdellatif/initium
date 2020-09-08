//
//  Customer.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import ObjectMapper
import SimpleTwoWayBinding

struct Customer {
    var id: String
    var firstName: String
    var lastName: String
}

struct RegistrationFormModel {
    let firstName: Observable<String> = Observable()
    let lastName: Observable<String> = Observable()
    let mobileNo: Observable<String> = Observable()
    let civilId: Observable<String> = Observable()
    let email: Observable<String> = Observable()
    let password: Observable<String> = Observable()
    let retypePassword: Observable<String> = Observable()
}
