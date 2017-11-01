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
    
    self.testRectangle.frame = CGRect(x: 25, y: 25, width: 50, height: 50)
  }
    
}
