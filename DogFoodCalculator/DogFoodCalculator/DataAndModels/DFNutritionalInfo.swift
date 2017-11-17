//
//  DFNutritionalInfo.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

enum DFMacroNutrientTypes : String {
  case fat = "fat"
  case protein = "protein"
  case carbs = "carbs"
  case fiber = "fiber"
  
  func caloriesPerGram() -> Float {
    switch self {
      case .fat:
        return 9.0
      case .protein, .carbs, .fiber:
        return 4.0
    }
  }
}

struct DFMacroNutrient {
  let macroType: DFMacroNutrientTypes
  let grams: Float
  
  func calories() -> Float {
    return max(grams, 0.0) * macroType.caloriesPerGram()
  }
}

struct DFNutritionalInfo {
  let measurementUnit: DFMeasurementUnit
  let fat: DFMacroNutrient
  let protein: DFMacroNutrient
  let carbs: DFMacroNutrient
  let fiber: DFMacroNutrient
  
  init(unit: DFMeasurementUnit,
       fat: Float = 0.0,
       protein: Float = 0.0,
       carbs: Float = 0.0,
       fiber: Float = 0.0) {
    self.measurementUnit = unit
    self.fat = DFMacroNutrient(macroType: DFMacroNutrientTypes.fat, grams: fat)
    self.protein = DFMacroNutrient(macroType: DFMacroNutrientTypes.protein, grams: protein)
    self.carbs = DFMacroNutrient(macroType: DFMacroNutrientTypes.carbs, grams: carbs)
    self.fiber = DFMacroNutrient(macroType: DFMacroNutrientTypes.fiber, grams: fiber)
  }
  
  private func caloriesForDefaultUnit() -> Float {
    return self.fat.calories() + self.protein.calories() + self.carbs.calories() + self.fiber.calories()
  }
  
  func calculateCaloriesForMeasurement(measurement: DFMeasurement) throws -> Float {
    do {
      let newMeasurement = try measurement.convertTo(newMeasurementUnit: self.measurementUnit)
      return newMeasurement.measurementValue * self.caloriesForDefaultUnit()
    } catch {
      throw error
    }
    
  }
}
