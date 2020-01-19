//
//  IconPresenter.swift
//  sAssist
//
//  Created by Lora Kucher on 17.01.2020.
//  Copyright © 2020 Lora Kucher. All rights reserved.
//

import Foundation

protocol IconPresenterView: class {
    func reload()
}

final class IconPresenter {
    
    // MARK: - public properties
    weak var view: IconPresenterView?
    
    public var items = [IconModel]() {
        didSet {
            self.view?.reload()
        }
    }
    
    // MARK: - init/deeinit
    init(with view: IconPresenterView) {
        self.view = view
    }
    
    // MARK: - public methods
    func getIcons() {
        IconRequestModel.getIconList { icons in
            self.items = icons
        }
    }
}
