//
//  IconView.swift
//  sAssist
//
//  Created by Lora Kucher on 16.01.2020.
//  Copyright © 2020 Lora Kucher. All rights reserved.
//

import UIKit

final class IconView: UIViewController {

    // MARK: - private IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - private properties
    private lazy var presenter = IconPresenter(with: self)
    
    // MARK: 0 life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.getIcons()
    }
}

// MARK: - presenter procol methods
extension IconView: IconPresenterView {
    
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - collection view datasouce
extension IconView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "icon_cell", for: indexPath) as? IconCell else {
            preconditionFailure("cell is nil")
        }
        // get images from presenter items
        cell.imgView.image = #imageLiteral(resourceName: "011-fish")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // do something
        self.navigationController?.popViewController(animated: true)
    }
}
