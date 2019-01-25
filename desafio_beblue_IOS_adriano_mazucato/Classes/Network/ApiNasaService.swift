//
//  ApiNasaService.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class ApiNasaService: NSObject {

    static func fetchPhotos(_ camera: String, date: String,
                            completionHandler: @escaping(_ response: Result<PhotoResponse>) -> ()) {
                
        let path = "/\(camera)/photos?earth_date=\(date)"
        APIConsumer<PhotoResponse>.consume(path: path) { (response) in
            completionHandler(response)
        }
    }
}
