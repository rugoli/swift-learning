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
  
  func testUpdateIngredient() {
    let initialIngredient = DFIngredientModel(ingredientName: "Test",
                                              supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp],
                                              defaultMeasurementUnit: DFMeasurementUnit.tsp,
                                              isSelected: false,
                                              amount: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 4.0))
    self.testRecipe.addIngredient(initialIngredient)
    
    let newAmount = DFIngredientModelBuilder(fromModel: initialIngredient)
      .withIngredientMeasurement(DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 3.0))
      .build()
    self.testRecipe.updateIngredient(oldIngredient: initialIngredient, withNewIngredient: newAmount)
    XCTAssertFalse(self.testRecipe.getIngredients().contains(initialIngredient))
    XCTAssertTrue(self.testRecipe.getIngredients().contains(newAmount))
  }
  
  func testAddIngredient() {
    XCTAssertTrue(self.testRecipe.getIngredients().count == 0)
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.getIngredients().count == 1)
  }
  
  func testRemoveIngredient() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    
    let ingredientToRemove = DFRecipeTests.testIngredient()
    self.testRecipe.addIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.getIngredients().count == 2)
    XCTAssertTrue(self.testRecipe.getIngredients().contains(ingredientToRemove))
    
    self.testRecipe.removeIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.getIngredients().count == 1)
    XCTAssertFalse(self.testRecipe.getIngredients().contains(ingredientToRemove))
  }
  
  func testRemoveAllIngredients() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.getIngredients().count == 2)
    
    self.testRecipe.removeAllIngredients()
    XCTAssertTrue(self.testRecipe.getIngredients().count == 0)
  }
  
  private class func testIngredient() -> DFIngredientModel {
    return DFIngredientModel(ingredientName: "Test: \(arc4random_uniform(100))", supportedMeasurementUnits: [DFMeasurementUnit.cup, DFMeasurementUnit.tsp])
  }
}
