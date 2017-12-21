//
//  DFIngredientGeneratorHelper.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan on 12/20/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit
@testable import DogFoodCalculator

protocol DFIngredientGeneratorHelper {
  func generateTestIngredient() -> DFIngredientModel
}

extension DFIngredientGeneratorHelper {
  func generateTestIngredient() -> DFIngredientModel {
    let measurementValue = Float(arc4random_uniform(5) + 1)
    return DFIngredientModel(ingredientName: "Test: \(arc4random_uniform(10000))",
      supportedMeasurementUnits: [DFMeasurementUnit.cup, DFMeasurementUnit.tsp],
      nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 1.0), fat: 1.0, protein: 3.0, carbs: 2.0, fiber: 1.0),
      amount: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: measurementValue))
  }
}
