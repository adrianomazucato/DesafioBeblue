//
//  ImageViewZoom.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

public protocol ImageViewZoomDelegate : class {
    func viewForZooming(zoomView: ImageViewZoom) -> UIView?
}

public extension ImageViewZoomDelegate {
    func viewForZooming(zoomView: ImageViewZoom) -> UIView? {
        return zoomView.imageView
    }
}

private extension UIScrollView {
    func hideIndicators() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
}

@IBDesignable
public class ImageViewZoom: UIScrollView {
        
    public weak var _delegate: ImageViewZoomDelegate?
    public var imageView: UIImageView!
    var cacheImage: UIImage!
    
    @IBInspectable public var image: UIImage! {
        didSet{
            guard let _imageView = self.imageView else {
                cacheImage = image
                return
            }
            _imageView.image = image
        }
    }
    
    @IBInspectable public var _minimumZoomScale: CGFloat = 1.0 {
        didSet{
            self.minimumZoomScale = _minimumZoomScale
        }
    }
    
    @IBInspectable public var _maximumZoomScale: CGFloat = 6.0 {
        didSet{
            self.maximumZoomScale = _maximumZoomScale
        }
    }
    
    public var contentModeImageView : UIView.ContentMode = .scaleAspectFit {
        didSet{
            self.contentMode = contentModeImageView
            self.sizeToFit()
            self.contentSize = self.imageView.intrinsicContentSize
            self.imageView.contentMode = contentModeImageView
        }
    }
    
    public var highlightedImage: UIImage? = nil {
        didSet {
            self.imageView.highlightedImage = highlightedImage
        }
    }
    
    public var isHighlighted: Bool = false {
        didSet {
            self.imageView.isHighlighted = isHighlighted
        }
    }
    
    public var animationImages: [UIImage]? = nil {
        didSet {
            self.imageView.animationImages = animationImages
        }
    }
    
    public var highlightedAnimationImages: [UIImage]? = nil {
        didSet{
            self.imageView.highlightedAnimationImages = highlightedAnimationImages
        }
    }
    
    public var animationDuration: TimeInterval = TimeInterval() {
        didSet{
            self.imageView.animationDuration = animationDuration
        }
    }
    
    public var animationRepeatCount: Int = 0 {
        didSet{
            self.imageView.animationRepeatCount = animationRepeatCount
        }
    }
    
    override public var tintColor: UIColor! {
        didSet{
            self.imageView.tintColor = tintColor
        }
    }
    
    public func startAnimating() {
        self.imageView.startAnimating()
    }
    
    public func stopAnimating() {
        self.imageView.stopAnimating()
    }
    
    public var isAnimating: Bool {
        get{
            return self.imageView.isAnimating
        }
    }
    
    public override func awakeFromNib() {
        self.imageView = UIImageView(frame: self.frame)
        self.imageView.contentMode = contentModeImageView
        self.contentMode = contentModeImageView
        self.imageView.clipsToBounds = true
        self.addSubview(imageView)
        if let _cache = cacheImage {
            self.imageView.image = _cache
        }
        self.hideIndicators()
        self.setupTap()
        self.delegate = self
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        self.setZoomScale(1.0, animated: true)
    }
}


extension ImageViewZoom: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self._delegate?.viewForZooming(zoomView: scrollView as! ImageViewZoom)
    }
}
