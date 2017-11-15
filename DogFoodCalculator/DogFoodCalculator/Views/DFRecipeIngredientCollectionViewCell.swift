//
//  DFRecipeIngredientCollectionViewCell.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeIngredientCollectionViewCell: UICollectionViewCell {
  private let ingredientNameLabel: UILabel
  private var ingredientViewModel: DFIngredientCellViewModel!
  static let reuseIdentifier: String = "recipe-ingredient-cell"
  
  override init(frame: CGRect) {
    ingredientNameLabel = UILabel()
    ingredientNameLabel.textColor = UIColor.white
    ingredientNameLabel.numberOfLines = 0
    ingredientNameLabel.textAlignment = NSTextAlignment.center
    ingredientNameLabel.font = ingredientNameLabel.font.withSize(18)
    
    super.init(frame: frame)
    self.backgroundColor = UIColor.blue
    self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    self.addSubview(ingredientNameLabel)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
    
}

// MARK: configuring views and models

extension DFRecipeIngredientCollectionViewCell {
  
  func configureCellWithViewModel(_ viewModel: DFIngredientCellViewModel) {
    self.ingredientViewModel = viewModel
    
    self.configureIngredientLabel()
    self.setIngredientNameLabelConstraints()
  }
  
  func configureIngredientLabel() {
    self.ingredientNameLabel.text = self.ingredientViewModel.ingredientName
  }
}

// MARK: Autolayout constraints

extension DFRecipeIngredientCollectionViewCell {
  private func setIngredientNameLabelConstraints() {
    ingredientNameLabel.removeConstraints(ingredientNameLabel.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let labelSize: CGSize = ingredientNameLabel.sizeThatFits(CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: cellSize.height))
    
    ingredientNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: ingredientNameLabel, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topPadding = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: ingredientNameLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
    let width = NSLayoutConstraint(item: ingredientNameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.width)
    let height = NSLayoutConstraint(item: ingredientNameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.height)
    NSLayoutConstraint.activate([centering, topPadding, width, height])
  }
}
