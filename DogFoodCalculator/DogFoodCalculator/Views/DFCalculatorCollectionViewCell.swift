//
//  DFCalculatorCollectionViewCell.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFCalculatorCollectionViewCell: UICollectionViewCell {
  private let testRectangle: UIView
  static let reuseIdentifier: String = "calculator-cell"
  
  override init(frame: CGRect) {
    self.testRectangle = UIView()
    self.testRectangle.backgroundColor = UIColor.red
    
    super.init(frame: frame)
    self.backgroundColor = UIColor.white
    
    self.addSubview(self.testRectangle)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    testRectangle.translatesAutoresizingMaskIntoConstraints = false
    let horizontalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: testRectangle, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: testRectangle, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
    let widthConstraint = NSLayoutConstraint(item: testRectangle, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 50)
    let heightConstraint = NSLayoutConstraint(item: testRectangle, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 50)
    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
  }
    
}
