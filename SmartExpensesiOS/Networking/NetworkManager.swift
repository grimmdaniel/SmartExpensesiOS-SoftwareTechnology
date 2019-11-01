//
//  NetworkManager.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 01/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func performNetworkRequest(with httpObject: HTTPObject, completionHandler: @escaping (Result<Response,NetworkError>) -> Void) {
        guard let url = URL(string: httpObject.urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpObject.type.rawValue
        urlRequest.allHTTPHeaderFields = httpObject.httpHeader
        
        if httpObject.type == .POST {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpObject.httpBody, options: [])
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                completionHandler(.failure(.responseError));return
            }
            
            guard let responseData = data else {
                completionHandler(.failure(.responseError));return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(.failure(.NOStatusCode));return
            }
            
            if (200 ... 299) ~= statusCode {
                guard let responseJSON = (try? JSONSerialization.jsonObject(with: responseData)) as? [String:Any] else {
                    completionHandler(.failure(.JSONFormatError));return
                }
                
                completionHandler(.success(responseJSON))
            } else {
                if statusCode == 400 {
                    completionHandler(.failure(.badRequest));return
                } else if statusCode == 404 {
                    completionHandler(.failure(.notFound404));return
                } else {
                    completionHandler(.failure(.internalServerError));return
                }
            }
        }).resume()
    }
    
    typealias Response = [String:Any]
}
