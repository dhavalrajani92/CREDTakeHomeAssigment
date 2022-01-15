//
//  ColllectionViewLayout.swift
//  CREDAssignment
//
//  Created by Rajani, Dhaval on 14/01/22.
//

import Foundation
import UIKit

// MARK: Properties and Variables
class ColllectionViewLayout: UICollectionViewLayout {

  //Cache to store layout of each cell.
  private var cache: [UICollectionViewLayoutAttributes] = []

  // Returns the number of items in the collection view
  private  var numberOfItems: Int {
    return collectionView?.numberOfItems(inSection: 0) ?? 0
  }

  //Equals height/width of card. Example - card that is 3 units wide and 2 units high will have 2/3 = 0.667 aspect ratio.
  private var cardAspectRatio: CGFloat = 0.63

  //size of front card.
  //Front card is the one which is completely visible to user and is not blocked by any other card.
  private var frontCardSize: CGSize = .zero

  //size of behind card.
  //Behind card is the one which is not partially visible to the user.
  private var behindCardSize: CGSize = .zero

  //padding between cell and contentView
  private var cellPadding: UIEdgeInsets = UIEdgeInsets.init()

  //Percentage of total card height that will be visible when card is behind another card.
  //value ranges from 0 to 1.
  private var behindCardVisibility: CGFloat = .zero

  func setCellProperties(_ padding: UIEdgeInsets? = nil, behindCardVisibility percentage: CGFloat? = nil) {
    if let cellPadding = padding {
      self.cellPadding = cellPadding
    }

    if let percentage = percentage {
      self.behindCardVisibility = percentage
    }
  }

  func setCardAspectRatio(_ cardAspectRatio: CGFloat) {
    self.cardAspectRatio = cardAspectRatio
  }
}

// MARK: UICollectionViewLayout
extension ColllectionViewLayout {
  // Return the size of all the content in the collection view
  override var collectionViewContentSize : CGSize {
    let contentViewWidth = collectionView?.bounds.width ?? .zero
    return CGSize(width: contentViewWidth, height: self.calculateContentViewHeight(contentViewWidth: contentViewWidth, numberOfItems: numberOfItems))
  }

  //This is called at start & everytime collection views layout is invalidated.
  //Refer docs for more information.
  override func prepare() {
    cache.removeAll(keepingCapacity: false)

    self.frontCardSize = self.calculateFrontCardSize(contentViewWidth: collectionView?.bounds.width ?? .zero)
    self.behindCardSize = self.calculateBehindCardSize(frontCardSize: frontCardSize)

    let xOffset = self.cellPadding.left
    var yOffset: CGFloat = self.cellPadding.top

    for item in 0..<numberOfItems {
      // 1. Create an index path to the current cell, then create default attributes for it.
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

      // 2. Prepare the cell to move up, higher zIndex value will be on top
      attributes.zIndex = item

      // 3. create cell frame and set it
      yOffset += (item > 0 ? 1 : 0) * behindCardSize.height
      attributes.frame = CGRect(x: xOffset, y: yOffset, width: frontCardSize.width, height: frontCardSize.height)

      cache.append(attributes)
    }
  }

  // Return all attributes in the cache whose frame intersects with the rect passed to the method
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cache.filter({ $0.frame.intersects(rect) })
  }

  //MARK: Utility functions for layout calculation.
  func calculateFrontCardSize(contentViewWidth: CGFloat) -> CGSize {
    let cardWidth = contentViewWidth - (cellPadding.left + cellPadding.right)
    let cardHeight = cardWidth * self.cardAspectRatio
    return CGSize(width: cardWidth, height: cardHeight)
  }

  func calculateBehindCardSize(frontCardSize: CGSize) -> CGSize {
    return CGSize(width: frontCardSize.width, height: frontCardSize.height * self.behindCardVisibility)
  }

  func calculateContentViewHeight(contentViewWidth: CGFloat, numberOfItems: Int) -> CGFloat {
    guard numberOfItems > 0 else { return 0 }
    let frontCardSize = calculateFrontCardSize(contentViewWidth: contentViewWidth)
    let behindCardSize = calculateBehindCardSize(frontCardSize: frontCardSize)
    return cellPadding.top + CGFloat(numberOfItems - 1) * behindCardSize.height + frontCardSize.height + cellPadding.bottom
  }
}
