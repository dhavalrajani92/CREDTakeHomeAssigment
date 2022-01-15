//
//  AmountSelectionCollectionViewCell.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import Foundation
import UIKit

final class AmountSelectionCollectionViewCell: UICollectionViewCell {
  static let identifier: String = "AmountSelectionCollectionViewCell"
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Hoefler Text", size: 16.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    return label
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Hoefler Text", size: 12.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    return label
  }()
  
  private lazy var dummyView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.layer.cornerRadius = 18
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionViewCell()
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    
    self.addSubview(titleLabel)
    self.addSubview(subTitleLabel)
    self.addSubview(dummyView)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      
      subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
      
      dummyView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      dummyView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      dummyView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16),
      dummyView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
      dummyView.heightAnchor.constraint(equalToConstant: self.frame.size.height/2)
    ])
  }
  
  func renderCell(title: String, subTitle: String?) {
    titleLabel.text = title
    subTitleLabel.text = subTitle
  }
}

extension AmountSelectionCollectionViewCell: CollectionViewProtocol {}
