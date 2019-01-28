//
//  PhotoItemViewModel.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

struct PhotoItemViewModel {

    let imgSrc: String?
    
    init(photo: Photo) {
        self.imgSrc = photo.imgSrc
    }
    
}
