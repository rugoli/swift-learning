//
//  DFRecipeTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan Goli on 11/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFRecipeTests: XCTestCase {
  private var testRecipe: DFRecipe = DFRecipe()
  
  func testAddIngredient() {
    XCTAssertTrue(self.testRecipe.ingredients.count == 0)
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.ingredients.count == 1)
  }
  
  func testRemoveIngredient() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    
    let ingredientToRemove = DFRecipeTests.testIngredient()
    self.testRecipe.addIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.ingredients.count == 2)
    XCTAssertTrue(self.testRecipe.ingredients.contains(ingredientToRemove))
    
    self.testRecipe.removeIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.ingredients.count == 1)
    XCTAssertFalse(self.testRecipe.ingredients.contains(ingredientToRemove))
  }
  
  func testRemoveAllIngredients() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.ingredients.count == 2)
    
    self.testRecipe.removeAllIngredients()
    XCTAssertTrue(self.testRecipe.ingredients.count == 0)
  }
  
  private class func testIngredient() -> DFIngredientModel {
    return DFIngredientModel(ingredientName: "Test: \(arc4random_uniform(100))", supportedMeasurementUnits: [DFMeasurementUnit.cup, DFMeasurementUnit.tsp])
  }
}