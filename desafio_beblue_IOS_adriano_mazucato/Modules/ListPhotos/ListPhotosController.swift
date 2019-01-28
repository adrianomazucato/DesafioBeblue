//
//  ListPhotosController.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class ListPhotosController: NSObject {
    
    enum Camera: String {
        case curiosity = "curiosity"
        case opportunity = "opportunity"
        case spirit = "spirit"
        
        static var allValues:[String] {
            return ["curiosity", "opportunity", "spirit"]
        }
        
//        func title()-> String {
//            switch self {
//            case .curiosity:
//                return "curiosity"
//            case .opportunity:
//                return "opportunity"
//            case .spirit:
//                return "spirit"
//            }
//        }

        //TODO: pegar itesm do enum
//        static var allCases: [String] {
//            var values: [String] = []
//            for camera in Camera.allCases {
//                values.append(camera)
//            }
//            return values
//        }
    }
    
    private var camera: Camera = .curiosity
    
    private var currentDate: Date = Date(){
        didSet {
            fetchPhotos()
        }
    }
    
    @objc dynamic var indexCamera: Int = 0 {
        didSet {
            selectCamera(at: indexCamera)
        }
    }
    
    let viewModel: ListPhotosViewModel
    var photosData: [Photo] = [Photo]()
    
    init(viewModel: ListPhotosViewModel = ListPhotosViewModel()) {
        self.viewModel = viewModel
        
        
    }
    
    private func fetchPhotos() {
        photosData.removeAll()
        ApiNasaService.fetchPhotos(camera.rawValue, date: currentDate.apiFormatterDate) { ( response ) in
            switch(response) {
            case .success(let value):
                    print(value)
                    if let photos = value.photos {
                        self.checkPhotos(photos: photos)
                    }
                break
            case .error(let error):
                self.viewModel.viewStateObservable.value = .error(error: error.localizedDescription)
                break
            }
        }
    }
    
    private func checkPhotos(photos: [Photo]) {
        if photos.isEmpty {
            currentDate = currentDate.addDay(-1)
        } else {
            photosData.append(contentsOf: photos)
            self.viewModel.viewStateObservable.value = .refresh(photos: photos)
        }
    }
    
    public func selectCamera(at position: Int) {
        self.viewModel.viewStateObservable.value = .loading
        camera = Camera(rawValue: Camera.allValues[position])!
        currentDate = Date()
    }
    
    public func start() {
        self.viewModel.viewStateObservable.value = .loading
        fetchPhotos()
    }
}

extension ListPhotosController {
    func countPhotos() -> Int {
        return photosData.count
    }

    func createViewModelItem(at position: Int)-> PhotoItemViewModel {
        return PhotoItemViewModel(photo: photosData[position])
    }
}
