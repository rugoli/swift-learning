//
//  DFRecipeIngredientCollectionViewCell.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFRecipeIngredientCellDelegate : class {
  func removedIngredientFromRecipe(cell: DFRecipeIngredientCollectionViewCell, ingredient: DFIngredientModel)
}

class DFRecipeIngredientCollectionViewCell: UICollectionViewCell {
  private let ingredientNameLabel: UILabel
  private let ingredientValueLabel: UILabel
  private let xOutButton: UIButton
  private var ingredientViewModel: DFIngredientCellViewModel!
  static let reuseIdentifier: String = "recipe-ingredient-cell"
  weak var delegate: DFRecipeIngredientCellDelegate?
  
  override init(frame: CGRect) {
    ingredientNameLabel = UILabel()
    ingredientNameLabel.textColor = UIColor.white
    ingredientNameLabel.numberOfLines = 0
    ingredientNameLabel.textAlignment = NSTextAlignment.center
    ingredientNameLabel.font = ingredientNameLabel.font.withSize(18)
    
    ingredientValueLabel = UILabel()
    ingredientValueLabel.textColor = UIColor.white
    ingredientValueLabel.numberOfLines = 1
    ingredientValueLabel.textAlignment = NSTextAlignment.center
    ingredientValueLabel.font = ingredientValueLabel.font.withSize(16)
    
    xOutButton = UIButton(type: UIButtonType.custom)
    xOutButton.setTitle("x", for: UIControlState.normal)
    xOutButton.setTitle("x", for: UIControlState.selected)
    xOutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    xOutButton.isHidden = false
    xOutButton.backgroundColor = UIColor.clear
    
    super.init(frame: frame)
    self.backgroundColor = UIColor.blue
    self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    xOutButton.addTarget(self, action: #selector(self.tappedRemoveIngredient(sender:)), for: UIControlEvents.touchUpInside)
    
    self.addSubview(ingredientNameLabel)
    self.addSubview(ingredientValueLabel)
    
    self.addSubview(xOutButton)
    self.setXOutButtonConstraints()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
  
  override var isHighlighted: Bool {
    willSet {
      let cellBackgroundColor = UIColor.init(red: 0, green: 0, blue: 1.0, alpha: newValue ? 0.5 : 1.0)
      self.backgroundColor = cellBackgroundColor
    }
  }
  
  @objc func tappedRemoveIngredient(sender: UIButton) {
    self.delegate?.removedIngredientFromRecipe(cell: self, ingredient: self.ingredientViewModel.ingredientModel)
  }
    
}

// MARK: configuring views and models

extension DFRecipeIngredientCollectionViewCell {
  
  func configureCellWithViewModel(_ viewModel: DFIngredientCellViewModel) {
    self.ingredientViewModel = viewModel
    
    self.configureIngredientLabel()
    self.setIngredientNameLabelConstraints()
    
    self.configureIngredientValueLabel()
    self.setIngredientValueLabelConstraints()
  }
  
  func configureIngredientLabel() {
    self.ingredientNameLabel.text = self.ingredientViewModel.ingredientName
  }
  
  func configureIngredientValueLabel() {
    self.ingredientValueLabel.text = self.ingredientViewModel.getIngredientAmount().prettyPrint()
  }
}

// MARK: Autolayout constraints

extension DFRecipeIngredientCollectionViewCell {
  private func setIngredientNameLabelConstraints() {
    ingredientNameLabel.removeConstraints(ingredientNameLabel.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let labelSize: CGSize = ingredientNameLabel.sizeThatFits(CGSize(width: cellSize.width - max(cellMargins.right, xOutButton.bounds.width) - cellMargins.left, height: cellSize.height))
    
    ingredientNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: ingredientNameLabel, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topPadding = NSLayoutConstraint(item: xOutButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: ingredientNameLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
    let width = NSLayoutConstraint(item: ingredientNameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.width)
    let height = NSLayoutConstraint(item: ingredientNameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.height)
    NSLayoutConstraint.activate([centering, topPadding, width, height])
  }
  
  private func setIngredientValueLabelConstraints() {
    ingredientValueLabel.removeConstraints(ingredientValueLabel.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let labelSize: CGSize = ingredientValueLabel.sizeThatFits(CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: cellSize.height))
    
    ingredientValueLabel.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: ingredientValueLabel, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topSpacing = NSLayoutConstraint(item: ingredientValueLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ingredientNameLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 10)
    let width = NSLayoutConstraint(item: ingredientValueLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.width)
    let height = NSLayoutConstraint(item: ingredientValueLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.height)
    NSLayoutConstraint.activate([centering, topSpacing, width, height])
  }
  
  private func setXOutButtonConstraints() {
    xOutButton.translatesAutoresizingMaskIntoConstraints = false
    let topAnchor = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: xOutButton, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
    let rightAnchor = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: xOutButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: xOutButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
    let height = NSLayoutConstraint(item: xOutButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
    NSLayoutConstraint.activate([topAnchor, rightAnchor, width, height])
  }
}
