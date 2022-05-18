//
//  UIView+extension.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 11/05/22.
//

import UIKit

extension UIView {
    func addSubviewIfAble(_ view: UIView?) {
        guard let view = view else {
            print(String(describing: view.self) + "Could not load the view because it was nil")
            return
        }
        self.addSubview(view)
    }
}
