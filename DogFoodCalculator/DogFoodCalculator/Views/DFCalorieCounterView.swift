//
//  DFCalorieCounterView.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/24/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFRecipeCalorieCounterDelegate : class {
  func openRecipeDetailView()
}

class DFCalorieCounterView: UIView {
  private var calorieCounterLabel: UILabel
  weak var delegate: DFRecipeCalorieCounterDelegate?
  
  required override init(frame: CGRect) {
    self.calorieCounterLabel = UILabel()
    self.calorieCounterLabel.textColor = DFColorPalette.colorForType(.calorieCounterText)
    self.calorieCounterLabel.numberOfLines = 1
    self.calorieCounterLabel.textAlignment = NSTextAlignment.center
    self.calorieCounterLabel.font = self.calorieCounterLabel.font.withSize(18)
    self.calorieCounterLabel.text = "0 calories"
    
    super.init(frame: frame)
    
    self.backgroundColor = DFColorPalette.colorForType(.calorieCounterBackground)
    self.addSubview(self.calorieCounterLabel)
    
    // gesture recognizers
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(openRecipeDetailView))
    swipeGesture.direction = UISwipeGestureRecognizerDirection.up
    self.addGestureRecognizer(swipeGesture)
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRecipeDetailView)))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setCalorieAmount(calories: Float) {
    self.calorieCounterLabel.text = "\(calories) calories"
  }
  
  func setAutolayoutConstraints() {
    self.calorieCounterLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let centerY = self.calorieCounterLabel.centerYConstraint(toView: self)
    let labelHeight = self.calorieCounterLabel.heightConstraint(forHeight: 18)
    let leftInset = NSLayoutConstraint(item: self.calorieCounterLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10)
    let rightInset = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: self.calorieCounterLabel, attribute: .right, multiplier: 1.0, constant: 10)
    
    NSLayoutConstraint.activate([centerY, labelHeight, leftInset, rightInset])
  }
  
}

// MARK: Gesture recognizers

extension DFCalorieCounterView {
  @objc private func openRecipeDetailView() {
    delegate?.openRecipeDetailView()
  }
}
