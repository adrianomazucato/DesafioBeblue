//
//  ObjectParser.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

enum ErrorType {
    
}

class ObjectParser<T: Decodable> {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = formatter.date(from: dateString) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Cannot decode date string \(dateString)")
        }
        return decoder
    }
    
    let jsonData :Data
    init(jsonData data:Data) {
        jsonData = data
    }
    
    public func parsedResponse() throws -> T {
        do {
            let decoder = try self.decoder.decode(T.self, from: jsonData)
            return decoder
        } catch {
            throw NSError(domain: "Error message.", code: 10)
        }
    }
}
