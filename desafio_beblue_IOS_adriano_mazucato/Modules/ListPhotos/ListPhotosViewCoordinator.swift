//
//  ListPhotosViewCoordinator.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

class ListPhotosViewCoordinator: Coordinator {

    override func start(completion: (() -> Void)? = nil) {
        let controller = ListPhotosController()
        let viewController = ListPhotosViewController(controller: controller )
        viewController.delegate = self
        if let navigationController = self.rootViewController as? UINavigationController {
            navigationController.viewControllers.append(viewController)
        }
    }
}

extension ListPhotosViewCoordinator: ListPhotosViewControllerDelegate {
    func listPhotosViewController(viewController: ListPhotosViewController, showPhotoDetail photo: Photo) {
        let detailCoordinator = PhotoDetailCoordinator(photo: photo, rootViewController: self.rootViewController)
        detailCoordinator.didEnd = {
            self.stopChild(coordinator: detailCoordinator)
        }
        detailCoordinator.startChild(coordinator: detailCoordinator)
    }
}
