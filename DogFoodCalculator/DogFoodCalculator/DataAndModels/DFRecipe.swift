//
//  DFRecipe.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipe: NSObject {
  public static let notificationUpdateKey: String = "updateModel"
  private var ingredients: [DFIngredientModel] = []
  
  func addIngredient(_ ingredient: DFIngredientModel) {
    self.ingredients.append(ingredient)
    self.postNotificationForUpdate(DFRecipeUpdateModel(updateType: DFRecipeUpdateType.add, indexPath: self.ingredients.count - 1))
  }
  
  func updateIngredient(oldIngredient: DFIngredientModel, withNewIngredient newIngredient: DFIngredientModel) {
    let ingredientIndex = self.getIndexForIngredient(oldIngredient)
    
    switch ingredientIndex {
      case nil:
        self.addIngredient(newIngredient)
      default:
        self.ingredients[ingredientIndex!] = newIngredient
        self.postNotificationForUpdate(DFRecipeUpdateModel(updateType: DFRecipeUpdateType.update, indexPath: ingredientIndex!))
    }
  }
  
  func removeIngredient(_ ingredient: DFIngredientModel) {
    if let ingredientIndex = self.getIndexForIngredient(ingredient) {
      self.ingredients.remove(at: ingredientIndex)
      self.postNotificationForUpdate(DFRecipeUpdateModel(updateType: DFRecipeUpdateType.remove, indexPath: ingredientIndex))
    }
  }
  
  func removeAllIngredients() {
    self.ingredients.removeAll()
  }
  
  func getIngredients() -> [DFIngredientModel] {
    return self.ingredients
  }
  
  private func getIndexForIngredient(_ targetIngredient: DFIngredientModel) -> Int? {
    return self.ingredients.index { (ingredient) -> Bool in
      ingredient.id == targetIngredient.id
    }
  }
}

// MARK: Update observers

extension DFRecipe {
  func addRecipeUpdateObserver(_ observer: DFRecipeUpdateListener) {
    NotificationCenter.default.addObserver(observer, selector: #selector(DFRecipeUpdateListener.observeRecipeUpdate(notification:)), name: DFRecipeUpdateModel.notificationName, object: self)
  }
  
  func removeObserver(_ observer: DFRecipeUpdateListener) {
    NotificationCenter.default.removeObserver(observer, name: DFRecipeUpdateModel.notificationName, object: self)
  }
  
  func postNotificationForUpdate(_ update: DFRecipeUpdateModel) {
    NotificationCenter.default.post(name: DFRecipeUpdateModel.notificationName, object: self, userInfo: [DFRecipe.notificationUpdateKey : update])
  }
}

// MARK: Calorie calculations

extension DFRecipe {
  func recipeCalorieCount() -> Float {
    var calories: Float = 0
    for anIngredient : DFIngredientModel in self.ingredients {
      calories += anIngredient.ingredientCalories()
    }
    return calories
  }
}
