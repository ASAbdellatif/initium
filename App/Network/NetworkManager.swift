//
//  NetworkManager.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager {
    
//    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<ApiService>()
    
    
    func getHomeList(completion: @escaping ([Organization]?, String?) -> Void) {
        provider.request(.getHome) { result in
            switch result {
            case let .success(response):
                
                do {
                    let homeResponse = try response.mapObject(HomeResponse.self)
                    if homeResponse.errorFlag != nil && homeResponse.errorFlag == false {
                        completion (homeResponse.data, nil)
                    } else {
                        completion (nil, "Error : \(homeResponse.errorDesc ?? "Not defined")")
                    }
                } catch {
                    completion (nil, "Error while mapping")
                }
            case let .failure(error):
                completion (nil, error.errorDescription)
            }
        }
    }
    
    
    func register(model: RegistrationFormModel, completion: @escaping (String?, String?) -> Void) {
        provider.request(.register(firstName: model.firstName.value ?? "", lastName: model.lastName.value  ?? "",
                                   mobileNo: model.mobileNo.value  ?? "", civilId: model.civilId.value  ?? "",
                                   email: model.email.value  ?? "", password: model.password.value  ?? "")) { result in
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    debugPrint(str)
                    let registrationResponse = try response.mapObject(RegistrationResponse.self)
                    if registrationResponse.errorFlag != nil && registrationResponse.errorFlag == false {
                        completion (registrationResponse.id, nil)
                    } else {
                        completion (nil, "Error : \(registrationResponse.errorDesc ?? "Not defined")")
                    }
                } catch {
                    completion (nil, "Error while mapping")
                }
            case let .failure(error):
                completion (nil, error.errorDescription)
            }
        }
    }
    
    
    func login (email: String, password: String, completion: @escaping (Customer?, String?) -> Void) {
        provider.request(.login(email: email, password: password)) { result in
        
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    debugPrint(str)
                    let loginResponse = try response.mapObject(LoginResponse.self)
                    
                    if loginResponse.errorFlag != nil && loginResponse.errorFlag == false {
                        let customer = Customer(id: loginResponse.id!, firstName: loginResponse.firstName!, lastName: loginResponse.lastName!)
                        completion (customer, nil)
                    } else {
                        completion (nil, "Error : \(loginResponse.errorDesc ?? "Not defined")")
                    }
                } catch {
                    completion (nil, "Error while mapping")
                }
            case let .failure(error):
                completion (nil, error.errorDescription)
            }
        }
    }
}
