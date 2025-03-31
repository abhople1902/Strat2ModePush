//
//  UIImageViewExtension.swift
//  Downforce
//
//  Created by Ayush Bhople on 31/03/25.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil, viewModel: NewsImageViewModel) {
        self.image = placeholder
        viewModel.loadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            self.image = image
        }
    }
}
