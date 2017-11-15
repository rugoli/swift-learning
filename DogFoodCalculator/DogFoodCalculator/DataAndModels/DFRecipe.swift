//
//  DFRecipe.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipe: NSObject {
  private var ingredients: [DFIngredientModel] = []
  
  func addIngredient(_ ingredient: DFIngredientModel) {
    self.ingredients.append(ingredient)
  }
  
  func updateIngredient(oldIngredient: DFIngredientModel, withNewIngredient newIngredient: DFIngredientModel) {
    let ingredientIndex = self.ingredients.index { (ingredient) -> Bool in
      ingredient.id == oldIngredient.id
    }
    
    switch ingredientIndex {
      case nil:
        self.addIngredient(newIngredient)
      default:
        self.ingredients[ingredientIndex!] = newIngredient
    }
  }
  
  func removeIngredient(_ ingredient: DFIngredientModel) {
    if self.ingredients.contains(ingredient) {
      self.ingredients = self.ingredients.filter{$0 != ingredient}
    }
  }
  
  func removeAllIngredients() {
    self.ingredients.removeAll()
  }
  
  func getIngredients() -> [DFIngredientModel] {
    return self.ingredients
  }
}
