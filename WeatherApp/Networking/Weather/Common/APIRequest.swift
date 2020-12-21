//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class APIRequest: Encodable {
    
    public func toDictionary() -> [String:AnyObject]? {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
            return dictionary
        }
        catch {
            
        }
        
        return nil
    }
    
    public func toQueryDictionary() -> [String: String]? {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
            return dictionary
        }
        catch {
            
        }
        
        return nil
    }
}
