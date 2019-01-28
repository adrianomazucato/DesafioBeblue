//
//  APIConsumer.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import Alamofire

enum Result<Value> {
    case success(Value)
    case error(Error)
}

class APIConsumer<T: Codable>: NSObject {
    
    public static func consume(path: String, completionHandler: @escaping(_ response: Result<T>) -> ()) {
        
        let parameters: Parameters = [:]
    
        Alamofire.request(Constants.baseURL + path + "&api_key=" + Constants.API_KEY,
                          method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<T>) in
                
                switch response.result {
                case .success(let object):
                    completionHandler(Result.success(object))
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                    completionHandler(Result.error(error))
                }
        })
    }
}
