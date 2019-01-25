//
//  ListPhotosController.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class ListPhotosController {
    
    enum Camera: String {
        case curiosity = "curiosity"
        case opportunity = "opportunity"
        case spirit = "spirit"

        static var allCases: [String] {
            let values: [String] = ["curiosity", "opportunity" , "spirit"]
            return values
        }
    }
    
    private var camera: Camera = .curiosity
    
    private var currentDate: Date = Date(){
        didSet {
            fetchPhotos()
        }
    }
    
    let viewModel: ListPhotosViewModel
    var photosData: [Photo] = [Photo]()
    
    init(viewModel: ListPhotosViewModel = ListPhotosViewModel()) {
        self.viewModel = viewModel
    }
    
    private func fetchPhotos() {
        photosData.removeAll()
        
        print("camera \(camera)")
        
        ApiNasaService.fetchPhotos(camera.rawValue, date: currentDate.apiFormatterDate) { ( response ) in
            switch(response) {
            case .success(let value):
                    print(value)
                    if let photos = value.photos {
                        self.checkPhotos(photos: photos)
                    }
                break
            case .error(let error):
                self.viewModel.observable.value = .error(error: error.localizedDescription)
                break
            }
        }
    }
    
    private func checkPhotos(photos: [Photo]) {
        if photos.count > 0 {
            photosData.append(contentsOf: photos)
            self.viewModel.observable.value = .refresh(photos: photos)
        } else {
            currentDate = currentDate.addDay(-1)
        }
    }
    
    public func selectCamera(at position: Int) {
        self.viewModel.observable.value = .loading
        camera = Camera(rawValue: Camera.allCases[position])!
        currentDate = Date()
    }
    
    public func start() {
        self.viewModel.observable.value = .loading
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
