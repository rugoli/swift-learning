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
  
  init(ingredientCollectionView: UICollectionView = UICollectionView(),
       recipeCollectionView: UICollectionView = UICollectionView()) {
    self.ingredientCollectionView = ingredientCollectionView
    self.recipeCollectionView = recipeCollectionView
    
    super.init(frame: CGRect.zero)
    
    self.addSubview(self.ingredientCollectionView)
    self.addSubview(self.recipeCollectionView)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}

// MARK: autolayout constraints

extension DFHomescreenView {
  
  func setAllConstraints() {
    self.setIngredientCollectionViewConstraints()
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
    let height = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 300)
    NSLayoutConstraint.activate([topSpacing, leftAnchor, rightAnchor, height, width])
  }
}
