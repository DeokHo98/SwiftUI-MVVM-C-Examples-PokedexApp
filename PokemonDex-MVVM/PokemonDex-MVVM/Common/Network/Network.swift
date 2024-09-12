//
//  Network.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import Foundation

// MARK: - EndPoint

protocol NetworkEndPoint {
    var path: String { get }
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
}

// MARK: - NetworkService

protocol NetworkServiceDependecny {
    /// Performs a network request and decodes the response into the specified Decodable type.
    func requestData<T: Decodable>(endPoint: NetworkEndPoint) async throws -> T
}

struct NetworkService: NetworkServiceDependecny {
    func requestData<T: Decodable>(endPoint: NetworkEndPoint) async throws -> T {
        let urlString = endPoint.baseURL + endPoint.path
        let httpMethod = endPoint.httpMethod
        logging(urlString: urlString, httpMethod: httpMethod)
        let url = try getURL(urlString: urlString)
        let request = createRequest(url: url, httpMethod: httpMethod)
        let (data, response) = try await fetchDataAsync(request: request)
        try validateResponse(response: response, urlString: urlString)
        return try decodeData(data)
    }
}

// MARK: - NetworkService Helper Function

extension NetworkService {
    /// logging Network Request function
    private func logging(urlString: String, httpMethod: HTTPMethod) {
        Log.network("Start Request", "URL: \(urlString)", "HTTPMethod: \(httpMethod.rawValue)")
    }
    
    /// logging Network Response function
    private func logging(urlString: String, statusCode: Int) {
        Log.network("Complete Response", "URL: \(urlString)", "StatusCode: \(statusCode)")
    }
    
    /// Creates a URL from the urlString
    private func getURL(urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            Log.error("Bad URL", urlString)
            throw URLError(.badURL)
        }
        return url
    }
    
    /// Creates a URLRequest from a URL
    private func createRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    /// Fetch data asynchronously from the network using the provided request
    private func fetchDataAsync(request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await URLSession.shared.data(for: request)
        } catch {
            Log.error("URLSession Error", error.localizedDescription)
            throw error
        }
    }
    
    /// Validates the HTTP response
    private func validateResponse(response: URLResponse, urlString: String) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            Log.error("No Response Exists")
            throw URLError(.badServerResponse)
        }
        let statusCode = httpResponse.statusCode
        logging(urlString: urlString, statusCode: statusCode)
        guard (200...299).contains(statusCode) else {
            Log.error("StatusCode is Invalid", statusCode)
            throw URLError(.badServerResponse)
        }
    }
    
    /// Decodes the response data into the specified Decodable type
    private func decodeData<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            Log.error("Decode Error", error.localizedDescription)
            throw error
        }
    }
}
