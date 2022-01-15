//
//  RoudedCornerButton.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import UIKit

final class RoudedCornerButton: UIView {
  private let title: String
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = title
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Hoefler Text", size: 16.0)
    label.textColor = UIColor(red: 196/255, green: 189/255, blue: 199/255, alpha: 1)
    return label
  }()
  
  init(title: String) {
    self.title = title
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.roundCorners(corner: [.topLeft, .topRight], size: CGSize(width: 18, height: 18))
  }
  
  private func setupView() {
    self.backgroundColor = UIColor(red: 46/255, green: 57/255, blue: 116/255, alpha: 1.0)
    
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
      titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
  
  
  func setTitle(title: String) {
    titleLabel.text = title
  }
}
