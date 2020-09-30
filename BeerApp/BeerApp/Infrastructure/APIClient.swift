//
//  APIClient.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

class APIClient {
    
    private static let baseURL = URL(string: "http://34.245.99.203:8080")!
    
    enum Endpoint {
        case beerList
        case beerDetail(Int)
        case beerCreate
        
        var path: String {
            switch self {
            case .beerList: return "/api/list/beer/"
            case .beerDetail(let id): return "/api/beer/\(id)/"
            case .beerCreate: return "/api/beer/"
            }
        }
        
        var request: URLRequest {
            return URLRequest(url: URL(string: self.path, relativeTo: baseURL)!)
        }
    }
    
    // MARK: - Public
    
    func get<T: Codable>(from endpoint: Endpoint, responseType: T.Type, completionHandler: @escaping (T?) -> ()) {
        dataTask(with: endpoint.request, responseType: responseType) { decodedResponse, _, _ in
            completionHandler(decodedResponse)
        }
    }
    
    func post<B: Codable, T: Codable>(to endpoint: Endpoint, requestBody: B, responseType: T.Type, completionHandler: @escaping (Bool) -> ()) {
        var request = endpoint.request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        dataTask(with: request, responseType: responseType) { decodedResponse, responseMetadata, error in
            if let httpResponse = responseMetadata as? HTTPURLResponse {
                completionHandler(httpResponse.statusCode == 200) // if success -> true
            } else {
                completionHandler(false) // else success -> false
            }
        }
    }
    
    // MARK: - Private
    
    private func dataTask<T: Codable>(with request: URLRequest, responseType: T.Type, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, responseMetadata, error in
            guard
                let data = data,
                let decodedResponse = try? JSONDecoder().decode(responseType, from: data)
            else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                completionHandler(nil, responseMetadata, error)
                return
            }

            completionHandler(decodedResponse, responseMetadata, error)
        }.resume()
    }
    
}
