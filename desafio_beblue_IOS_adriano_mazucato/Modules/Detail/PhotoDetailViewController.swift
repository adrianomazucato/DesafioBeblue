//
//  PhotoDetailViewController.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerDelegate: class {
    func photoDetailViewController(didEnd viewController: PhotoDetailViewController)
}

class PhotoDetailViewController: UIViewController {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var namePhoto: AnimatedLabel = {
        let label = AnimatedLabel()
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    weak var delegate: PhotoDetailViewControllerDelegate?
    let photo: Photo
    
    public init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupAutoLayout()
        configureTouchName()
        setupUI()
        start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            self.delegate?.photoDetailViewController(didEnd: self)
        }
    }
}

extension PhotoDetailViewController {
    func addViews() {
        self.view.addSubview(namePhoto)
        self.view.addSubview(imageView)
    }
    
    func setupAutoLayout() {
        namePhoto.mrk.top(to: self.view)
        namePhoto.mrk.left(to: self.view, constant: 20)
        namePhoto.mrk.right(to: self.view)
        namePhoto.mrk.height(45)
        
        imageView.mrk.top(to: namePhoto, attribute: .bottom)
        imageView.mrk.left(to: self.view)
        imageView.mrk.right(to: self.view)
        imageView.mrk.bottom(to: self.view)
    }
    
    func configureTouchName() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoDetailViewController.tapName))
        namePhoto.addGestureRecognizer(tap)
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
    
    func start() {
        if let source = photo.imgSrc, let url = URL(string: source) {
            self.imageView.kf.setImage(with: url)
        }
        
        namePhoto.text = photo.camera?.name
    }
    
    @objc func tapName() {
        namePhoto.text = photo.camera?.fullName
    }
}
