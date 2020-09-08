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
        defaults.set(firstName, forKey: "firstName")
        defaults.set(lastName, forKey: "lastName")
        defaults.set(true, forKey: "userLoggedIn")

    }
    
    func getUser() -> (firstName: String, lastName: String) {
        let firstName = UserDefaults.standard.string(forKey: "firstName")!
        let lastName = UserDefaults.standard.string(forKey: "lastName")!

        return (firstName, lastName)
    }
    func deleteUser() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userLoggedIn")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "userLoggedIn")
    }
}
