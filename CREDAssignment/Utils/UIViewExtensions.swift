//
//  UIViewExtensions.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import UIKit

extension UIView {
  func pinViewToEdge(_ parent: UIView, inset: UIEdgeInsets = .zero) {
    NSLayoutConstraint.activate([
      self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: inset.left),
      self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: inset.right),
      self.topAnchor.constraint(equalTo: parent.topAnchor, constant: inset.top),
      self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: inset.bottom)
    ])
  }
  
  func roundCorners(corner: UIRectCorner, size: CGSize) {
    let path = UIBezierPath(roundedRect:self.bounds,
                            byRoundingCorners:corner,
                            cornerRadii: size)

    let maskLayer = CAShapeLayer()

    maskLayer.path = path.cgPath
    self.layer.mask = maskLayer
  }
}

