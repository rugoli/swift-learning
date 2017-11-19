//
//  DFIngredientCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFIngredientDataSourceAdapterProtocol : class {
  func updateModel(model: DFIngredientModel, atIndexPath indexPath: IndexPath)
}

class DFIngredientCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  let numIngredients: Int = 10
  weak var recipeBuilder: DFRecipeBuilder?
  private var ingredients: [DFIngredientModel] = [DFIngredientModel]()
  
  override init() {    
    super.init()
    
    self.generateIngredients()
  }
  
  // returns the index path of the model that was updated
  func updateIngredientModel(_ model: DFIngredientModel) -> IndexPath? {
    if let modelIndex = self.getIndexPathForIngredientModel(model) {
      self.ingredients[modelIndex.row] = model
      return modelIndex
    }
    return nil
  }
  
  func getIndexPathForIngredientModel(_ targetModel: DFIngredientModel) -> IndexPath? {
    let modelIndex: Int? = self.ingredients.index { (model) -> Bool in
      targetModel.id == model.id
    }
    
    if modelIndex != nil {
      return IndexPath(row: modelIndex!, section: 0)
    }
    return nil
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

extension DFIngredientCollectionViewDataSource : DFIngredientDataSourceAdapterProtocol {
  func updateModel(model: DFIngredientModel, atIndexPath indexPath: IndexPath) {
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
  
  private func generateRandomIngredient() -> DFIngredientModel {
    let randomInt: Int = Int(arc4random_uniform(3))
    switch randomInt {
    case 0:
      return DFIngredientModel(ingredientName: "Ground Turkey 99% Lean",
                               supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz, DFMeasurementUnit.g],
                               nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.g, measurementValue: 112.0),
                                                                  fat: 1.5, protein: 26, carbs: 0, fiber: 0),
                               defaultMeasurementUnit: DFMeasurementUnit.lb
                               )
    case 1:
      return DFIngredientModel(ingredientName: "Canned pumpkin",
                               supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp, DFMeasurementUnit.cup],
                               nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.tbsp, measurementValue: 8.0), fat: 0, protein: 2, carbs: 11, fiber: 3),
                               defaultMeasurementUnit: DFMeasurementUnit.tbsp
                               )
    case 2:
      return DFIngredientModel(ingredientName: "White rice",
                               supportedMeasurementUnits: [DFMeasurementUnit.cup],
                               nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: 0.25), fat: 0, protein: 3, carbs: 33, fiber: 0))
    default:
      return DFIngredientModel(ingredientName: "Ground Turkey 99% Lean",
                               supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz, DFMeasurementUnit.g],
                               nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.g, measurementValue:112.0),
                                                                  fat: 1.5, protein: 26, carbs: 0, fiber: 0),
                               defaultMeasurementUnit: DFMeasurementUnit.lb
                               )
    }
    
  }
}
