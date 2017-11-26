//
//  DFRecipeBreakdownRowView.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/26/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeBreakdownRowView: UIView {
  var breakdownName: UILabel
  var percentage: UILabel
  
  required init(viewModel: DFRecipeBreakdownRowViewModel) {
    self.breakdownName = UILabel()
    self.breakdownName.textColor = DFColorPalette.colorForType(.calorieCounterText)
    self.breakdownName.numberOfLines = 0
    self.breakdownName.textAlignment = NSTextAlignment.left
    self.breakdownName.font = self.breakdownName.font.withSize(18)
    self.breakdownName.text = viewModel.name
    
    self.percentage = UILabel()
    self.percentage.textColor = DFColorPalette.colorForType(.calorieCounterText)
    self.percentage.numberOfLines = 0
    self.percentage.textAlignment = NSTextAlignment.right
    self.percentage.font = self.percentage.font.withSize(18)
    self.percentage.text = viewModel.formattedPercentage()
    
    super.init(frame: .zero)
    
    self.addSubview(self.percentage)
    self.addSubview(self.breakdownName)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setRowAlignmentConstraints() {
    self.percentage.translatesAutoresizingMaskIntoConstraints = false
    self.breakdownName.translatesAutoresizingMaskIntoConstraints = false
    
    let centerY = self.breakdownName.centerYConstraint(toView: self.percentage)
    let nameTopAnchor = self.breakdownName.constraintPaddingForDirection(padding: 0, direction: .top, toView: self)
    let percentageTopAnchor = self.percentage.constraintPaddingForDirection(padding: 0, direction: .top, toView: self)
    let leftAnchor = self.breakdownName.constraintPaddingForDirection(padding: 0, direction: .left, toView: self)
    let rightAnchor = self.percentage.constraintPaddingForDirection(padding: 0, direction: .right, toView: self)
    
    NSLayoutConstraint.activate([centerY, nameTopAnchor, percentageTopAnchor, leftAnchor, rightAnchor])
  }
}
