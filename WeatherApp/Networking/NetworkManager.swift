//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Alamofire
import Foundation

class NetworkManager {
    
    func performRequest(url: URL, method: HTTPMethod ) {
        print("Performing request: \(url)")
        
        AF.request(url, method: method).response { response in
            self.handleAPIResponse(data: response)
        }
    }
    
    func handleAPIResponse(data: AFDataResponse<Data?>) {
        
    }
    
    static func url(from urlString: String, queryParameters: [String: String]) -> URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = queryParameters.map({ URLQueryItem(name: $0.key, value:$0.value) })
        components?.queryItems = queryItems
        return components?.url
    }
}
