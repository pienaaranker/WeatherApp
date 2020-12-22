//
//  JSONHelper.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class JSONHelper {
    static func fetchJsonData(in file:String) throws -> Data {
        let path = Bundle(for:self).path(forResource: file, ofType: "json")
        return try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }
    
    static func fetchAndDecode<T: Decodable>(in file: String) -> T? {
        do {
            let data = try JSONHelper.fetchJsonData(in: file)
            let details: T = try JSONDecoder().decode(T.self, from: data)
            return details
        } catch {
            
        }
        
        return nil
    }
}
