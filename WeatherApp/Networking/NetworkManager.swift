//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Alamofire
import Foundation

struct APIError: Error {
///         enum ErrorKind {
///             case invalidCharacter
///             case mismatchedTag
///             case internalError
///         }
///
///         let line: Int
///         let column: Int
///         let kind: ErrorKind
///     }
}
class NetworkManager: NetworkManagable {
    
    func performRequest(url: URL, method: HTTPMethod, completion: @escaping (Data?, AFError?) -> Void) {
        print("Performing request: \(url)")
        
        logRequest(url: url)
        AF.request(url, method: method).response { response in
            self.logResponse(response: response)
            self.handleAPIResponse(response: response, completion: completion)
        }
        
    }
    
    func handleAPIResponse(response: AFDataResponse<Data?>, completion: (Data?, AFError?) -> Void) {
        switch response.response!.statusCode {
        case 200...299:
            completion(response.data, nil)
        case 400...499:
            completion(nil, response.error)
        case 500:
            completion(nil, response.error)
        default:
            let error = APIError()
            completion(nil, AFError.createURLRequestFailed(error: error))
        }
    }
    
    func logRequest(url: URL) {
        log("⚡️ API REQUEST")
        log("--------------------------------------")
        log(url)
        log("======================================")
    }
    
    func logResponse(response: AFDataResponse<Data?>) {
        let responseObject = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String: AnyObject]
        let data = try? JSONSerialization.data(withJSONObject: responseObject!, options: .prettyPrinted)
        let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        (200..<300).contains(response.response?.statusCode ?? 0) ?
            log("✅ API RESPONSE SUCCESS") :
            log("🚩 API RESPONSE ERROR")
        log("--------------------------------------")
        log(string)
        log("======================================")
    }
    
    func log(_ items: Any) {
        print(items)
    }
    
    static func url(from urlString: String, queryParameters: [String: String]) -> URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = queryParameters.map({ URLQueryItem(name: $0.key, value:$0.value) })
        components?.scheme = "http"
        components?.queryItems = queryItems
        return components?.url
    }
}
