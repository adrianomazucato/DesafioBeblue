//
//  ListPhotosViewModel.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class ListPhotosViewModel {
    enum ViewState {
        case none
        case loading
        case refresh(photos: [Photo])
        case error(error: String)
    }
    
    let viewStateObservable: Observable = Observable<ViewState>(.none)
}
