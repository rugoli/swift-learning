//
//  DFIngredientModelTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan on 12/20/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFIngredientModelTests: XCTestCase, DFIngredientGeneratorHelper {
  
  func testIncompatibleNutritionalUnit() {
    let ingredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [.tsp], nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 1.0), fat: 1.0, protein: 4.0, carbs: 5.0, fiber: 2.0))
    let invalidUnit: DFMeasurementUnit = DFMeasurementUnit.lb
    
    let calories = ingredient.ingredientCalories(measurement: DFMeasurement(measurementUnit: invalidUnit, measurementValue: 1.0))
    XCTAssertEqual(calories, 0.0)
  }
  
  func testCalorieCalculations() {
    let noNutrition = DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: 1.0))
    var ingredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [.cup], nutritionalInfo: noNutrition)
    var calories = ingredient.ingredientCalories(measurement: DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: 1.0))
    XCTAssert(calories == 0)
    
    let nutritionalInfo = DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 1.0), fat: 1.0, protein: 4.0, carbs: 5.0, fiber: 2.0)
    let numberOfUnits = DFMeasurement(measurementUnit: .cup, measurementValue: 2.0)
    ingredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [.cup], nutritionalInfo: nutritionalInfo, amount: numberOfUnits)
    
    // have to break this up because it apparently can't handle all four calculations together
    let fatProteinCals = (1.0 * 9.0 * numberOfUnits.measurementValue + 4.0 * 4 * numberOfUnits.measurementValue) as Float
    let carbsFiberCals = (5.0 * 4 * numberOfUnits.measurementValue + 2.0 * 4 * numberOfUnits.measurementValue) as Float
    calories = ingredient.ingredientCalories(measurement: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: numberOfUnits.measurementValue))
    XCTAssert(calories == (fatProteinCals + carbsFiberCals))
  }
  
  func testIngredientCaloricBreakdown() {
    let ingredient1 = generateTestIngredient()
    let calories1 = ingredient1.ingredientCalories()
    
    let ingredient2 = generateTestIngredient()
    let calories2 = ingredient2.ingredientCalories()
    
    let recipe = DFRecipe()
    recipe.addIngredient(ingredient1)
    recipe.addIngredient(ingredient2)
    let totalCalories = recipe.recipeCalorieCount()
    
    let caloricBreakdown = recipe.breakdownByIngredient()
    for breakdownRow: DFRecipeBreakdownRowViewModel in caloricBreakdown {
      switch breakdownRow.name {
      case ingredient1.ingredientName:
        XCTAssertEqual(100.00 * calories1 / totalCalories, breakdownRow.percentage)
      case ingredient2.ingredientName:
        XCTAssertEqual(100.00 * calories2 / totalCalories, breakdownRow.percentage)
      default:
        XCTFail("Found unexpected ingredient name in breakdown rows")
      }
    }
  }
  
  func testMacroCaloricBreakdown() {
    let ingredient = generateTestIngredient()
    let newMeasurement = try! ingredient.ingredientAmount.convertTo(newMeasurementUnit: ingredient.nutritionalInfo.servingSize.measurementUnit)
    let servingSizeRatio = (newMeasurement.measurementValue / ingredient.nutritionalInfo.servingSize.measurementValue)
    let macroBreakdown = ingredient.caloriesForMeasurementByMacro()
    
    XCTAssertEqual(macroBreakdown[.carbs]?.calories, servingSizeRatio * ingredient.nutritionalInfo.carbs.calories())
    XCTAssertEqual(macroBreakdown[.fat]?.calories, servingSizeRatio * ingredient.nutritionalInfo.fat.calories())
    XCTAssertEqual(macroBreakdown[.protein]?.calories, servingSizeRatio * ingredient.nutritionalInfo.protein.calories())
    XCTAssertEqual(macroBreakdown[.fiber]?.calories, servingSizeRatio * ingredient.nutritionalInfo.fiber.calories())
  }
  
  // test converting from non-serving size unit to serving size unit and getting correct calories
  func testCorrectCalorieCalculations() {
    let servingSize =  DFMeasurement(measurementUnit: DFMeasurementUnit.oz, measurementValue: 8.0)
    let nutritionalInfo = DFNutritionalInfo(servingSize: servingSize, fat: 1.0, protein: 1.0, carbs: 0, fiber: 0)
    let ingredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [.oz, .lb], nutritionalInfo: nutritionalInfo, amount: servingSize)
    
    let caloriesPerServingSize = ingredient.ingredientCalories()
    
    let twiceServingSize = DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)
    let caloriesForTwiceServing = ingredient.ingredientCalories(measurement: twiceServingSize)
    XCTAssertEqual(2 * caloriesPerServingSize, caloriesForTwiceServing)
  }
}
