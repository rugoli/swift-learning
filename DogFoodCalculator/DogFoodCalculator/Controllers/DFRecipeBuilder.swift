//
//  DFRecipeBuilder.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/14/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

// use class specifier to allow weak references
protocol DFRecipeBuilder : class {
  func addIngredient(_ ingredient: DFIngredientModel)
  func updateIngredient(oldIngredient: DFIngredientModel, withNewIngredient newIngredient: DFIngredientModel)
  func removeIngredient(_ ingredient: DFIngredientModel)
}
