//
//  NetworkError.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case hostNotFound
    case internalServerError
    case responseError
    case JSONFormatError
    case NOStatusCode
    case badRequest
    case notFound404
}
