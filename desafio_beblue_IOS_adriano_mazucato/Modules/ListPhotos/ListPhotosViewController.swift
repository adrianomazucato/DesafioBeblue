//
//  ListPhotosViewController.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

protocol ListPhotosViewControllerDelegate: class {
    func listPhotosViewController(viewController: ListPhotosViewController, showPhotoDetail photo: Photo)
}


class ListPhotosViewController: UIViewController {
    
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ListPhotosController.Camera.allCases)
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(ListPhotosViewController.valueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewFlowLayout(cellsPerRow: 2))
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .gray
        return indicatorView
    }()
    
    let controller: ListPhotosController
    weak var delegate: ListPhotosViewControllerDelegate?

    public init(controller: ListPhotosController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        commonInit()
        addViews()
        setupAutoLayout()
        bindViewModel()
        controller.start()
    }
}

extension ListPhotosViewController {
    func addViews() {
        self.view.addSubview(segmentedControl)
        self.view.addSubview(collectionView)
        self.view.addSubview(indicatorView)
    }
    
    func setupAutoLayout() {
        segmentedControl.mrk.top(to: self.view)
        segmentedControl.mrk.left(to: self.view)
        segmentedControl.mrk.right(to: self.view)
        segmentedControl.mrk.height(45)
        
        collectionView.mrk.top(to: segmentedControl, attribute: .bottom, constant: 3)
        collectionView.mrk.left(to: self.view)
        collectionView.mrk.right(to: self.view)
        collectionView.mrk.bottom(to: self.view)
        
        indicatorView.mrk.center(to: self.view)
    }
    
    func commonInit() {
        collectionView.registerClass(ItemPhotoCell.self)
        
        self.navigationItem.title = "Mars Rovers Photos"
    }
    
    @objc func valueChanged(segmentedControl: UISegmentedControl) {
        controller.selectCamera(at: segmentedControl.selectedSegmentIndex)        
    }
    
    func bindViewModel() {
        
        controller.viewModel.observable.bind { state in
            switch state {
            case .loading:
                self.collectionView.reloadData()
                self.indicatorView.isHidden = false
                self.indicatorView.startAnimating()
                break
            case .refresh(_):
                self.indicatorView.isHidden = true
                self.indicatorView.stopAnimating()
                self.collectionView.reloadData()
                break
            case .none: break
                
            case .error(let error): break
                
            }
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
}


extension ListPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.countPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.listPhotosViewController(viewController: self, showPhotoDetail: controller.photosData[indexPath.row])
    }
}

extension ListPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(ItemPhotoCell.self, indexPath: indexPath)
        cell.backgroundColor = .white
        cell.configure(controller.createViewModelItem(at: indexPath.row))
        return cell
    }
}
