//
//  PhotoDetailCoordinator.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class PhotoDetailCoordinator: Coordinator {
    
    let photo: Photo
    
    init(photo: Photo, rootViewController: UIViewController?) {
        self.photo = photo
        super.init(rootViewController: rootViewController)
    }

    override func start(completion: (() -> Void)?) {
        let controller = PhotoDetailViewController(photo: photo)
        if let navigationController = self.rootViewController as? UINavigationController {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
