//
//  StackViewDataSource.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//
import Foundation
import UIKit

enum StackViewType {
  case Amount
  case EMI
  case FinancialInstrument
}

struct StackViewData {
  var type: StackViewType
  var title: String
  var subTitle: String?
  var buttonTitle: String
  var isExpanded: Bool = false
}

protocol StackViewCollectionViewDelegate {
  func removeCell(index: Int)
}

final class StackViewDataSource: NSObject {
  
  private var data: [StackViewData]
  
  var delegate: StackViewCollectionViewDelegate?
  
  init(data: [StackViewData]) {
    self.data = data
  }
  
  var numberOfStackViews: Int {
    return data.filter({ $0.isExpanded == true }).count
  }
  
  private var lastExpadedIndex: Int? {
    return data.lastIndex(where: {$0.isExpanded == true })
  }

  func makeNextStackViewExpanded() {
    guard let lastExpadedIndex = lastExpadedIndex else {
      return
    }
    
    data[lastExpadedIndex + 1].isExpanded = true
  }
  
  func makeStackViewCollapsed(after index: Int) {
    guard index < data.count else { return }
    for (seq, _) in data.enumerated() {
      if seq > index {
        data[seq].isExpanded = false
      }
    }
  }
  
  var buttonTitle: String? {
    guard let lastExpadedIndex = lastExpadedIndex else {
      return nil
    }
    
    return data[lastExpadedIndex].buttonTitle
  }
}

extension StackViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.filter({ $0.isExpanded == true }).count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let title = data[indexPath.row].title
    let subTitle = data[indexPath.row].subTitle
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmountSelectionCollectionViewCell.identifier, for: indexPath) as? AmountSelectionCollectionViewCell else { return UICollectionViewCell() }
    cell.renderCell(title: title, subTitle: subTitle)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.makeStackViewCollapsed(after: indexPath.row)
    delegate?.removeCell(index: indexPath.row)
    collectionView.reloadData()
  }
}
