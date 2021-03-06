//
//  ForexAPI.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case invalidJSON
    
    var errorMessage: String {
        switch self {
        case .badURL:
            return "URL Inválida"
        default:
            return ""
        }
    }
}

class ForexAPI {
    
    private static let basePath = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&apikey=S0XOTXR7AS9YNLK8"
    
    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 30
        configuration.httpMaximumConnectionsPerHost = 5
        return configuration
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    static func loadAction(withSymbol symbol: String, onComplete: @escaping (Result<ForexQuote, APIError>) -> Void) {
        let path = "\(basePath)&symbol=\(symbol).SA"
        guard let url = URL(string: path) else {
            return onComplete(.failure(.badURL))
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return onComplete(.failure(.taskError))
            }
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.noResponse))
            }
            if !(200...299 ~= response.statusCode) {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            do {
                
                let forex = try JSONDecoder().decode(ForexQuote.self, from: data)
                return onComplete(.success(forex))
            } catch {
                return onComplete(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
    
    private func treatError() {
        
    }
}

enum HTTPMethod: String {
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

