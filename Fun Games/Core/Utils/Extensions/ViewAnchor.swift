//
//  ViewAnchor.swift
//  Fun Games
//
//  Created by Ludin Nento on 30/12/20.
//

import UIKit

extension UIView {
  func anchor(
    top: NSLayoutYAxisAnchor?, paddingTop: CGFloat,
    bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat,
    left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat,
    right: NSLayoutXAxisAnchor?, paddingRight: CGFloat,
    width: CGFloat, height: CGFloat
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    if let right = right {
      trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    if let left = left {
      leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
}
