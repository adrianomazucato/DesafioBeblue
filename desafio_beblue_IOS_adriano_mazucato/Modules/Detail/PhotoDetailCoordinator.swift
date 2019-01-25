//
//  PhotoDetailCoordinator.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class PhotoDetailCoordinator: Coordinator {
    
    let controller: PhotoDetailViewController
    var didEnd:(() -> Void)?
    
    init(photo: Photo, rootViewController: UIViewController?) {
        controller = PhotoDetailViewController(photo: photo)
        super.init(rootViewController: rootViewController)
        
        controller.delegate = self
    }

    override func start(completion: (() -> Void)?) {
        if let navigationController = self.rootViewController as? UINavigationController {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}

extension PhotoDetailCoordinator: PhotoDetailViewControllerDelegate {
    func photoDetailViewController(didEnd viewController: PhotoDetailViewController) {
        didEnd?()
    }
}
