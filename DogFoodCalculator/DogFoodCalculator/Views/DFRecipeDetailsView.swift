//
//  DFRecipeDetailsView.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeDetailsView: UIView {
  let recipe: DFRecipe
  let calorieCountLabel: UILabel
  let ingredientBreakdownTable: DFRecipeBreakdownTable
  let macroBreakdownTable: DFRecipeBreakdownTable
  
  let doneButton: UIButton
  let closeViewAction: () -> Void
  
  required init(recipe: DFRecipe,
                doneButtonAction: @escaping () -> Void) {
    self.recipe = recipe
    
    self.calorieCountLabel = UILabel()
    self.calorieCountLabel.textColor = DFColorPalette.colorForType(.calorieCounterText)
    self.calorieCountLabel.numberOfLines = 1
    self.calorieCountLabel.textAlignment = NSTextAlignment.center
    self.calorieCountLabel.font = self.calorieCountLabel.font.withSize(30)
    self.calorieCountLabel.text = "\(self.recipe.recipeCalorieCount()) calories"
    
    self.doneButton = UIButton(type: .system)
    self.doneButton.setTitle("Done", for: .normal)
    self.doneButton.setTitle("Done", for: .selected)
    self.doneButton.titleLabel?.font = self.doneButton.titleLabel?.font?.withSize(20)
    self.closeViewAction = doneButtonAction
    
    self.ingredientBreakdownTable = DFRecipeBreakdownTable(rows: recipe.breakdownByIngredient())
    self.macroBreakdownTable = DFRecipeBreakdownTable(rows: recipe.breakdownByMacros())
    
    super.init(frame: .zero)
    
    self.backgroundColor = DFColorPalette.colorForType(.recipeDetailsViewBackground)
    
    self.addSubview(self.calorieCountLabel)
    self.addSubview(self.doneButton)
    self.addSubview(self.ingredientBreakdownTable)
    self.addSubview(self.macroBreakdownTable)
    
    self.doneButton.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func tappedDoneButton() {
    self.closeViewAction()
  }
}

// MARK: Autolayout helpers

extension DFRecipeDetailsView {
  func setAllConstraints() {
    self.setCalorieCountLabelConstraints()
    self.setIngredientBreakdownTableConstraints()
    self.setMacroBreakdownTableConstraints()
    self.setDoneButtonConstraints()
  }
  
  private func setCalorieCountLabelConstraints() {
    self.calorieCountLabel.translatesAutoresizingMaskIntoConstraints = false
    let labelSize = calorieCountLabel.sizeThatFits(CGSize(width: self.bounds.size.width, height: 50))
    
    let topPadding = NSLayoutConstraint(item: calorieCountLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 30)
    let centerX = calorieCountLabel.centerXConstraint(toView: self)
    let width = calorieCountLabel.widthConstraint(forWidth: labelSize.width)
    let height = calorieCountLabel.heightConstraint(forHeight: labelSize.height)
    
    NSLayoutConstraint.activate([topPadding, centerX, width, height])
  }
  
  private func setIngredientBreakdownTableConstraints() {
    self.ingredientBreakdownTable.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint(item: ingredientBreakdownTable, attribute: .top, relatedBy: .equal, toItem: calorieCountLabel, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
    ingredientBreakdownTable.constraintPaddingForDirection(padding: 20, direction: .left, toView: self).isActive = true
    ingredientBreakdownTable.constraintPaddingForDirection(padding: 20, direction: .right, toView: self).isActive = true
    ingredientBreakdownTable.centerXConstraint(toView: self).isActive = true
  }
  
  private func setMacroBreakdownTableConstraints() {
    self.macroBreakdownTable.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint(item: macroBreakdownTable, attribute: .top, relatedBy: .equal, toItem: ingredientBreakdownTable, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
    macroBreakdownTable.constraintPaddingForDirection(padding: 20, direction: .left, toView: self).isActive = true
    macroBreakdownTable.constraintPaddingForDirection(padding: 20, direction: .right, toView: self).isActive = true
    macroBreakdownTable.centerXConstraint(toView: self).isActive = true
  }
  
  private func setDoneButtonConstraints() {
    self.doneButton.translatesAutoresizingMaskIntoConstraints = false
    let buttonSize = doneButton.sizeThatFits(CGSize(width: self.bounds.size.width, height: 50))
    
    let bottomAnchor = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: doneButton, attribute: .bottom, multiplier: 1.0, constant: 30)
    let centerX = doneButton.centerXConstraint(toView: self)
    let width = doneButton.widthConstraint(forWidth: buttonSize.width)
    let height = doneButton.heightConstraint(forHeight: buttonSize.height)
    
    NSLayoutConstraint.activate([bottomAnchor, centerX, width, height])
  }
}
