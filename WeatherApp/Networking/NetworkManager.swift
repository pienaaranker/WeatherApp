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
            self.handleAPIResponse(response: response)
        }
    }
    
    func handleAPIResponse(response: AFDataResponse<Data?>) {
        let responseObject = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String: AnyObject]
        let data = try? JSONSerialization.data(withJSONObject: responseObject!, options: .prettyPrinted)
        let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print(string)
        
        
        let weather = try? JSONDecoder().decode(WeatherCurrentResponse.self, from: response.data!)
        print(weather?.coord)
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
