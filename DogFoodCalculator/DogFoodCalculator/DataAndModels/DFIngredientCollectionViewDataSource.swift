//
//  DFIngredientCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFDataSourceAdapterProtocol : class {
  func updateModel(model: DFIngredientCellViewModel, atIndexPath indexPath: IndexPath)
}

class DFIngredientCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  let numIngredients: Int = 10
  weak var recipeBuilder: DFRecipeBuilder?
  var ingredients: [DFIngredientCellViewModel] = [DFIngredientCellViewModel]()
  
  override init() {    
    super.init()
    
    self.generateIngredients()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.numIngredients
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: DFIngredientsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DFIngredientsCollectionViewCell.reuseIdentifier, for: indexPath) as! DFIngredientsCollectionViewCell
    cell.configureCellWithModel(self.ingredients[indexPath.row])
    cell.delegate = self
    cell.recipeBuilder = self.recipeBuilder
    cell.indexPath = indexPath
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 180)
  }
}

extension DFIngredientCollectionViewDataSource : DFDataSourceAdapterProtocol {
  func updateModel(model: DFIngredientCellViewModel, atIndexPath indexPath: IndexPath) {
    self.ingredients[indexPath.row] = model
  }
}


// MARK: Test data generation

extension DFIngredientCollectionViewDataSource {
  private func generateIngredients() {
    for _ in 0..<self.numIngredients {
      self.ingredients.append(self.generateRandomIngredient())
    }
    
  }
  
  private func generateRandomIngredient() -> DFIngredientCellViewModel {
    let randomInt: Int = Int(arc4random_uniform(3))
    switch randomInt {
    case 0:
      return DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Ground Turkey 99% Lean", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.lb))
    case 1:
      return DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Canned pumpkin", supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp, DFMeasurementUnit.cup], defaultMeasurementUnit: DFMeasurementUnit.tbsp))
    case 2:
      return DFIngredientCellViewModel(DFIngredientModel(ingredientName: "White rice", supportedMeasurementUnits: [DFMeasurementUnit.cup]))
    default:
      return DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Ground Turkey 99% Lean", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.lb))
    }
    
  }
}
