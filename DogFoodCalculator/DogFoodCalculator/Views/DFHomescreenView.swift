//
//  DFHomescreenView.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/17/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFHomescreenView: UIView {
  let ingredientCollectionView: UICollectionView
  let recipeCollectionView: UICollectionView
  let calorieCounter: UILabel
  
  init(ingredientCollectionView: UICollectionView = UICollectionView(),
       recipeCollectionView: UICollectionView = UICollectionView()) {
    self.ingredientCollectionView = ingredientCollectionView
    self.recipeCollectionView = recipeCollectionView
    self.calorieCounter = UILabel()
    self.calorieCounter.textColor = UIColor.blue
    self.calorieCounter.numberOfLines = 1
    self.calorieCounter.textAlignment = NSTextAlignment.center
    self.calorieCounter.font = self.calorieCounter.font.withSize(18)
    self.calorieCounter.text = "Test"
    
    super.init(frame: CGRect.zero)
    
    self.addSubview(self.ingredientCollectionView)
    self.addSubview(self.recipeCollectionView)
    self.addSubview(self.calorieCounter)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}

// MARK: autolayout constraints

extension DFHomescreenView {
  
  func setAllConstraints() {
    self.setIngredientCollectionViewConstraints()
    self.setCalorieCounterConstraints()
    self.setRecipeCollectionViewConstraints()
  }
  
  private func setIngredientCollectionViewConstraints() {
    self.ingredientCollectionView.removeConstraints(ingredientCollectionView.constraints)
    
    ingredientCollectionView.translatesAutoresizingMaskIntoConstraints = false
    let topAnchor = NSLayoutConstraint(item: ingredientCollectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
    let leftAnchor = NSLayoutConstraint(item: ingredientCollectionView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
    let rightAnchor = NSLayoutConstraint(item: ingredientCollectionView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: ingredientCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
    let height = NSLayoutConstraint(item: ingredientCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 200)
    NSLayoutConstraint.activate([topAnchor, width, height, leftAnchor, rightAnchor])
  }
  
  private func setRecipeCollectionViewConstraints() {
    self.recipeCollectionView.removeConstraints(recipeCollectionView.constraints)
    
    recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    let topSpacing = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ingredientCollectionView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 10)
    let leftAnchor = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
    let rightAnchor = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
    NSLayoutConstraint.activate([topSpacing, leftAnchor, rightAnchor, width])
  }
  
  private func setCalorieCounterConstraints() {
    self.calorieCounter.removeConstraints(calorieCounter.constraints)
    
    calorieCounter.translatesAutoresizingMaskIntoConstraints = false
    let topPadding = NSLayoutConstraint(item: calorieCounter, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: recipeCollectionView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
    let bottomPadding = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: calorieCounter, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
    let centerX = NSLayoutConstraint(item: calorieCounter, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: calorieCounter, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
    let height = NSLayoutConstraint(item: calorieCounter, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30)
    NSLayoutConstraint.activate([topPadding, bottomPadding, centerX, width, height])
  }
}
