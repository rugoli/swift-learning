//
//  DFRecipeCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFRecipeCollectionViewDelegate : class, DFRecipeIngredientCellDelegate {
  func didTapRecipeIngredient(collectionView: UICollectionView, ingredientModel: DFIngredientModel)
}
  
class DFRecipeCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  var recipe: DFRecipe
  weak var delegate: DFRecipeCollectionViewDelegate?
  
  init(withRecipe recipe: DFRecipe) {
    self.recipe = recipe
    
    super.init()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.recipe.ingredients.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DFRecipeIngredientCollectionViewCell.reuseIdentifier, for: indexPath) as! DFRecipeIngredientCollectionViewCell
    cell.configureCellWithModel(self.recipe.ingredients[indexPath.row])
    cell.delegate = self.delegate
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    return CGSize(width: (collectionView.bounds.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing) / 2.0, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.delegate?.didTapRecipeIngredient(collectionView: collectionView, ingredientModel: self.recipe.ingredients[indexPath.row])
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  
}

