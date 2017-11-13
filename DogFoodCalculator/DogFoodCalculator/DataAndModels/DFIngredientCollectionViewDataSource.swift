//
//  DFIngredientCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFRecipeBuilder {
  func addIngredient(_ ingredient: DFIngredientModel)
  func removeIngredient(_ ingredient: DFIngredientModel)
}

class DFIngredientCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let numIngredients: Int = 10
    var ingredients: [DFIngredientModel] = [DFIngredientModel]()
    private var recipe: DFRecipe = DFRecipe()
    
    override init() {
        super.init()
        
        self.generateIngredients()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numIngredients
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DFCalculatorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DFCalculatorCollectionViewCell.reuseIdentifier, for: indexPath) as! DFCalculatorCollectionViewCell
        cell.configureCellWithModel(self.ingredients[indexPath.row])
        cell.recipeBuilderDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
    
}

// MARK: Recipe builder

extension DFIngredientCollectionViewDataSource : DFRecipeBuilder {
  func addIngredient(_ ingredient: DFIngredientModel) {
    self.recipe.addIngredient(ingredient)
  }
  
  func removeIngredient(_ ingredient: DFIngredientModel) {
    if self.recipe.ingredients.contains(ingredient) {
      self.recipe.removeIngredient(ingredient)
    }
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
                return DFIngredientModel(ingredientName: "Ground Turkey 99% Lean", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.lb)
            case 1:
                return DFIngredientModel(ingredientName: "Canned pumpkin", supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp, DFMeasurementUnit.cup], defaultMeasurementUnit: DFMeasurementUnit.tbsp)
            case 2:
                return DFIngredientModel(ingredientName: "White rice", supportedMeasurementUnits: [DFMeasurementUnit.cup])
            default:
                return DFIngredientModel(ingredientName: "Ground Turkey 99% Lean", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.lb)
        }
        
    }
}
