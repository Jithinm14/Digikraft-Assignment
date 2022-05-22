//
//  File.swift
//  
//
//  Created by Jithin M on 22/05/22.
//

import Foundation

enum HTTPMethod: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidUrl
    case noInternet
    case networkError
    case invalidData
}

protocol DataRequest {
    
    associatedtype Response
    
    var urlString: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String : String] { get }
    var headers: [String : String] { get }
    
    func decode(data: Data) throws -> Response
}

extension DataRequest {
    
    var queryParams: [String : String] {
        [:]
    }
    
    var headers: [String : String] {
        [:]
    }
    
}

extension DataRequest where Response: Decodable {
    
    func decode(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
}

protocol NetworkServiceProtocol {
    func fetchData<Request: DataRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<Request>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) where Request : DataRequest {
        
        guard var urlComponent = URLComponents(string: request.urlString) else {
            return completion(.failure(NetworkError.invalidUrl))
        }
        
        var queryItems = [URLQueryItem]()
        
        request.queryParams.forEach { queryItem in
            let urlQueryItem = URLQueryItem(name: queryItem.key, value: queryItem.value)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return completion(.failure(NetworkError.invalidUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(
            with: urlRequest) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    return completion(.failure(NetworkError.networkError))
                }
                
                guard let data = data else {
                    return completion(.failure(NetworkError.invalidData))
                }
                
                do {
                    try completion(.success(request.decode(data: data)))
                }
                catch {
                    completion(.failure(NetworkError.invalidData))
                }
            }.resume()
    }
    
    
    
}
