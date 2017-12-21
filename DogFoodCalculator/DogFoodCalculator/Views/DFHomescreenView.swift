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
  let calorieCounterView: DFCalorieCounterView
  
  init(ingredientCollectionView: UICollectionView = UICollectionView(),
       recipeCollectionView: UICollectionView = UICollectionView(),
       calorieCounterDelegate: DFRecipeCalorieCounterDelegate? = nil) {
    self.ingredientCollectionView = ingredientCollectionView
    self.recipeCollectionView = recipeCollectionView
    
    self.calorieCounterView = DFCalorieCounterView(frame: .zero)
    self.calorieCounterView.delegate = calorieCounterDelegate
    
    super.init(frame: CGRect.zero)
    
    self.addSubview(self.ingredientCollectionView)
    self.addSubview(self.recipeCollectionView)
    self.addSubview(self.calorieCounterView)
    self.backgroundColor = DFColorPalette.colorForType(.backgroundColor)
    
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHomeScreen))
    gestureRecognizer.delegate = self
    self.addGestureRecognizer(gestureRecognizer)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  func updateCalorieCounterLabel(calories: Float) {
    self.calorieCounterView.setCalorieAmount(calories: calories)
  }
}

// MARK: gesture recognizer

extension DFHomescreenView : UIGestureRecognizerDelegate {
  @objc
  private func didTapHomeScreen() {
    self.endEditing(true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return !(touch.view?.isKind(of: UICollectionViewCell.classForCoder()) ?? false || touch.view?.superview?.isKind(of: UICollectionViewCell.classForCoder()) ?? false)
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
    let height = ingredientCollectionView.heightConstraint(forHeight: 160)
    NSLayoutConstraint.activate([topAnchor, width, height, leftAnchor, rightAnchor])
  }
  
  private func setRecipeCollectionViewConstraints() {
    self.recipeCollectionView.removeConstraints(recipeCollectionView.constraints)
    
    recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    let topSpacing = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: ingredientCollectionView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    let leftAnchor = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
    let rightAnchor = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: recipeCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
    NSLayoutConstraint.activate([topSpacing, leftAnchor, rightAnchor, width])
  }
  
  private func setCalorieCounterConstraints() {
    self.calorieCounterView.removeConstraints(calorieCounterView.constraints)
    
    calorieCounterView.translatesAutoresizingMaskIntoConstraints = false
    let topAnchor = NSLayoutConstraint(item: calorieCounterView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: recipeCollectionView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
    let bottomAnchor = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: calorieCounterView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
    let width = NSLayoutConstraint(item: calorieCounterView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
    let height = calorieCounterView.heightConstraint(forHeight: 80)
    NSLayoutConstraint.activate([bottomAnchor, topAnchor, width, height])
    
    self.calorieCounterView.setAutolayoutConstraints()
  }
}
