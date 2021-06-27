//
//  UIImage+.swift
//  Soyeon
//
//  Created by 이재은 on 2021/06/05.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(targetWidth: CGFloat) -> UIImage {
        let screenScale = UIScreen.main.scale
        let scale = targetWidth / self.size.width
        let targetHeight = self.size.height * scale
        let size = CGSize(width: targetWidth, height: targetHeight)
        let targetRect: CGRect = CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight).integral(screenScale)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: targetRect)
        }
        return renderImage
    }
}

private extension CGRect {
    func integral(_ scale: CGFloat) -> CGRect {
        return CGRect(x: floor(origin.x * scale) / scale,
                      y: floor(origin.y * scale) / scale,
                      width: ceil(size.width * scale) / scale,
                      height: ceil(size.height * scale) / scale)
    }
}
