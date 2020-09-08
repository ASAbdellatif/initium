//
//  Service.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    private init() {}
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "userLoggedIn")
    }
    
    func saveUser(firstName: String, lastName: String) {
        let defaults = UserDefaults.standard
        let dic = ["firstName": firstName, "lastName": lastName]
        defaults.set(dic, forKey: "customer")
        defaults.set(true, forKey: "userLoggedIn")
    }
    
    func getUser() -> (firstName: String, lastName: String) {
        let customer = UserDefaults.standard.dictionary(forKey: "customer") as! [String : String]
        return (customer["firstName"]!, customer["lastName"]!)
    }
    func deleteUser() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userLoggedIn")
        defaults.removeObject(forKey: "customer")
    }
}
