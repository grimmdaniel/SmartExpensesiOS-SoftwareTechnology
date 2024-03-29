//
//  HTTPObject.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class HTTPObject {
    
    private static let rootURL = "https://smarte-flask.herokuapp.com"
    static let httpHeader = ["Content-Type": "application/json"]
    
    static func createHeaderWithAuthentication(apiKey: String) -> [String:String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
    }
    
    let type: HTTPMethod
    let urlString: String
    let httpHeader: [String:String]
    let httpBody: [String:Any]
    
    init(type: HTTPMethod, endpoint: EndPoints, httpHeader: [String:String], httpBody: [String:Any]) {
        self.type = type
        self.urlString = HTTPObject.rootURL + endpoint.rawValue
        self.httpHeader = httpHeader
        self.httpBody = httpBody
    }
    
    init(type: HTTPMethod, endpoint: EndPoints, urlParameter: Int, httpHeader: [String:String], httpBody: [String:Any]) {
        self.type = type
        self.urlString = HTTPObject.rootURL + endpoint.rawValue + "/\(urlParameter)"
        self.httpHeader = httpHeader
        self.httpBody = httpBody
    }
}
