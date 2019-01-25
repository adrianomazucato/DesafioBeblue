//
//  ItemPhotoCell.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit
import Kingfisher

class ItemPhotoCell: UICollectionViewCell {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ItemPhotoCell {
    
    func addViews() {
        self.contentView.addSubview(imageView)
    }
    
    func makeConstraints() {
        imageView.mrk.top(to: self.contentView)
        imageView.mrk.left(to: self.contentView)
        imageView.mrk.right(to: self.contentView)
        imageView.mrk.bottom(to: self.contentView)
    }
    
    func configure(_ viewModel: PhotoItemViewModel) {
        if let source = viewModel.imgSrc, let url = URL(string: source) {
            self.imageView.kf.setImage(with: url)
        }
    }
}
