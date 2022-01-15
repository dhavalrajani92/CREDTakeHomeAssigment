//
//  CollectionViewProtocol.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import UIKit

protocol CollectionViewProtocol where Self:UIView {
  func setupCollectionViewCell()
}

extension CollectionViewProtocol {
  func setupCollectionViewCell() {
    self.layer.cornerRadius = 28
    self.backgroundColor = UIColor(red: 19/255, green: 26/255, blue: 31/255, alpha: 1.0)
  }
}
