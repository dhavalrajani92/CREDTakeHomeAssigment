//
//  ViewController.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import UIKit

final class ViewController: UIViewController {
  
  private lazy var layout = ColllectionViewLayout()
  
  private let rawData: [StackViewData] = [
    StackViewData(type: .Amount, title: "dhaval, how much do you need?", subTitle: "move the dial and set any amount you need up to $5000", buttonTitle: "Proceed to EMI selection", isExpanded: true),
    StackViewData(type: .EMI, title: "how do you wish to repay?", subTitle: "choose one of our recommended plans or make your own", buttonTitle: "Select your bank account"),
    StackViewData(type: .FinancialInstrument, title: "Where should we send the money?", subTitle: "amount will be credited to this bank account. EMI will also be debited from this bank account", buttonTitle: "Tap for 1-click KYC")
  ]
  
  private lazy var dataSource = StackViewDataSource(data: rawData)
  
  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .close)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var infoButton: UIButton = {
    let button = UIButton(type: .infoDark)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var stackCollectionView: UICollectionView = {
    layout.setCellProperties(nil, behindCardVisibility: 1)
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  private lazy var rounderCornerButton: RoudedCornerButton = {
    let button = RoudedCornerButton(title: "Proceed to EMI selection")
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    registerNibs()
    setupGestureRecogniser()
  }
  
  private func setupView() {
    self.view.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
    
    self.view.addSubview(closeButton)
    self.view.addSubview(infoButton)
    self.view.addSubview(stackCollectionView)
    self.view.addSubview(rounderCornerButton)
    
    NSLayoutConstraint.activate([
      closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      
      infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      
      stackCollectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
      stackCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      rounderCornerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      rounderCornerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      rounderCornerButton.topAnchor.constraint(equalTo: stackCollectionView.bottomAnchor, constant: 20),
      rounderCornerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      
    ])
    dataSource.delegate = self
    stackCollectionView.delegate = dataSource
    stackCollectionView.dataSource = dataSource
  }
  
  private func registerNibs() {
    stackCollectionView.register(AmountSelectionCollectionViewCell.self, forCellWithReuseIdentifier: AmountSelectionCollectionViewCell.identifier)
  }
  
  private func setupGestureRecogniser() {
    let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(addCell))
    rounderCornerButton.addGestureRecognizer(tapGestureRecogniser)
  }
  
  @objc func addCell() {
    guard dataSource.numberOfStackViews < rawData.count else {
      return
    }
    
    stackCollectionView.collectionViewLayout.invalidateLayout()
    
    layout.setCellProperties(behindCardVisibility: 0.7)
    
    
    dataSource.makeNextStackViewExpanded()
    stackCollectionView.reloadData()
    
    guard let buttonTitle = dataSource.buttonTitle else { return }
    setButtonTitle(buttonTitle: buttonTitle)
  }
  
  func setButtonTitle(buttonTitle: String) {
    rounderCornerButton.setTitle(title: buttonTitle)
  }
}


extension ViewController: StackViewCollectionViewDelegate {
  func removeCell(index: Int) {
    guard let buttonTitle = dataSource.buttonTitle else { return }
    setButtonTitle(buttonTitle: buttonTitle)
  }
}
