//
//  DFRecipeCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFRecipeCollectionViewDelegate : class {
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
    return self.recipe.getIngredients().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DFRecipeIngredientCollectionViewCell.reuseIdentifier, for: indexPath) as! DFRecipeIngredientCollectionViewCell
    cell.configureCellWithViewModel(DFIngredientCellViewModel(self.recipe.getIngredients()[indexPath.row]))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    return CGSize(width: (collectionView.bounds.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing) / 2.0, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.delegate?.didTapRecipeIngredient(collectionView: collectionView, ingredientModel: self.recipe.getIngredients()[indexPath.row])
  }
}

