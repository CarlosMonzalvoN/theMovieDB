//
//  Client.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 10/05/22.
//

import UIKit

class Client {
    
    static func parseJson<T: Decodable>(jsonName: String, model: T.Type) -> T?{
        guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json") else { return nil }
        do{
            let data = try Data(contentsOf: url)
            let jsonDecoder =  JSONDecoder()
            do{
                let responseModel = try jsonDecoder.decode(T.self, from: data)
                return responseModel
            }catch{
                debugPrint("Credential Error: \(error)")
                return nil
            }
        }catch{
            return nil
        }
    }
    
}
