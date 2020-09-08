//
//  ApiService.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import Foundation
import Moya

enum ApiService {
    case getHome
    case register(firstName: String, lastName: String, mobileNo: String, civilId: String, email: String, password: String)
    case login (email: String, password: String)
}

extension ApiService: TargetType {
    
    // This is the base URL we'll be using, typically our server.
    var baseURL: URL {
        switch self {
        case .getHome:
            return URL(string: Constants.ProductionServer.homeBaseURL)!
        case .register:
            return URL(string: Constants.ProductionServer.registerBaseURL)!
        case .login:
            return URL(string: Constants.ProductionServer.loginBaseURL)!
        }
    }

    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .getHome:
            return "/workflows/454307d87b9a401d9908ebc9ffe0cccb/triggers/manual/paths/invoke"
        case .register(_, _, _, _, _, _):
            return "/workflows/2b388c189a8042d8a8011dea9a4dffc2/triggers/manual/paths/invoke"
        case .login(_, _):
            return "/workflows/0d82783b372144f39d80734118867ced/triggers/manual/paths/invoke"
        }
    }

    // Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getHome:
            return .post
        case .register:
            return .post
        case .login:
            return .post
        }
    }

    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    // In this example we will not pass anything in the body of the request.
    var task: Task {
        switch self {
        case .getHome:
            return .requestParameters(parameters: [
                "api-version": "2016-06-01",
                "sp": "/triggers/manual/run",
                "sv": "1.0",
                "sig": "kVqO2Ou8fCAbdg634i3eh2Sg6xXrD1Uj8brhuNrZD-g"
            ], encoding: URLEncoding.queryString)
            
        case let .register (firstName, lastName, mobileNo, civilId, email, password):
            return .requestCompositeParameters(bodyParameters: [
                "CustomerFirstName": firstName,
                "CustomerLastName": lastName,
                "CustomerMobileNo": mobileNo,
                "CustomerCivilID": civilId,
                "CustomerEmail": email,
                "CustomerPassword": password
            ], bodyEncoding: JSONEncoding.default, urlParameters: [
                "api-version": "2016-06-01",
                "sp": "/triggers/manual/run",
                "sv": "1.0",
                "sig": "ncxT3y2VEzCw0b7xKIz75oINuFmNrlaeohK7SIYaORs"
            ])
            
        case let .login(email, password):
            return .requestCompositeParameters(bodyParameters: [
                "CustomerEmail": email,
                "CustomerPassword": password
                ], bodyEncoding: JSONEncoding.default, urlParameters: [
                    "api-version": "2016-06-01",
                    "sp": "/triggers/manual/run",
                    "sv": "1.0",
                    "sig": "uoLTJf5Pf_LO8pZdhQvebsJ_FFMP9wMd0wNRjjCnY3U"
            ])
        }
        
    }

    // These are the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String: String]? {
        return  ["Content-Type": "application/json"]
    }

    // This is sample return data that you can use to mock and test your services,
    // but we won't be covering this.
    var sampleData: Data {
        return Data()
    }
}

