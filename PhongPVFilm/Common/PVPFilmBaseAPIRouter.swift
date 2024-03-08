//
//  PVPFilmBaseAPIRouter.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

protocol PVPFilmBaseAPIRouter {
    func baseUrl()    -> String
    func headers()    -> [String: String]
    func path()       -> String
    func method()     -> HTTPMethod
    func parameters() -> [String: Any]
    
    func request(completion: ((Swift.Result<Data, Error>) -> Void)?)
}

enum HTTPMethod: String {
    case GET
    case POST
    // TODO: Bổ sung ác method
}

extension PVPFilmBaseAPIRouter {
    func headers() -> [String: String] {
        ["Content-Type": "application/json"]
    }
    
    func request(completion: ((Swift.Result<Data, Error>) -> Void)?) {
        //create request
        let urlString = baseUrl() + path()
        guard let url = URL(string: urlString) else {
            completion?(.failure(PVPFilmError.localError(message: "Có lỗi xảy ra với đường dẫn \(urlString).")))
            return
        }
        let httpMethod = method()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        switch httpMethod {
        case .GET:
            let parameters = parameters()
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        case .POST:
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters(), options: .prettyPrinted)
        }
        
        headers().forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        //config
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        //session
        let session = URLSession(configuration: config)
        
        //connect
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion?(.failure(error))
                } else if let data = data {
                    completion?(.success(data))
                } else {
                    completion?(.failure(PVPFilmError.localError(message: "Có lỗi xảy ra khi lấy dữ liệu.")))
                }
            }
        }
        
        task.resume()
    }
    
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape(value.boolValue ? "1" : "0")))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape(bool ? "1" : "0")))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    public func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        let batchSize = 50
        var index = string.startIndex
        
        while index != string.endIndex {
            let startIndex = index
            let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
            let range = startIndex..<endIndex
            
            let substring = string[range]
            
            escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
            
            index = endIndex
        }
        
        return escaped
    }
    
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
