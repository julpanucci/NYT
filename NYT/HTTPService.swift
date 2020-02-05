//
//  HTTPService.swift
//  NYT
//
//  Created by Julian Panucci on 2/4/2020.
//  Copyright © 2020 Panucci. All rights reserved.
//

import Foundation

class HTTPService {
    let session = URLSession.shared
    
    typealias GenericResponse<T: Codable> = (Result<T, Error>) -> Void
    
    
    func sendRequest<T: Codable>(url: URL?, method: HTTPMethod = .get, body: [String: Any]? = nil, queryParams: [String: String]? = nil, completion: @escaping GenericResponse<T>) {
        
        guard let newUrl = url else {
            fatalError("Error with url: \(String(describing: url))")
        }
        
        var components = URLComponents(string: newUrl.absoluteString)
        components?.queryItems = []
        if let queryParams = queryParams {
            for (name,  value) in queryParams {
                components?.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        
        guard let compURL = components?.url else {
            fatalError("Error with url: \(String(describing: url))")
        }
        
        
        let request = URLRequest(url: compURL)
        self.sendRequest(urlRequest: request, method: method, body: body, completion: completion)
    }
    
    func sendRequest<T: Codable>(urlRequest: URLRequest, method: HTTPMethod = .get, body: [String: Any]?, completion: @escaping GenericResponse<T>) {
        var request = urlRequest
        
        if method == .post {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        request.httpMethod = method.rawValue
        
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
        
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    let object = try JSONDecoder().decode(T.self, from: data) 
                    completion(.success(object))
                    return
                }
            } catch(let error) {
                print(error)
                completion(.failure(error))
            }
            
        }.resume()
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
