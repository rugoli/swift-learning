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
  
  static func allTypes() -> [DFMacroNutrientTypes] {
    return [.fat, .protein, .carbs, .fiber]
  }
}

struct DFMacroNutrient {
  let macroType: DFMacroNutrientTypes
  let grams: Float
  
  func calories() -> Float {
    return max(grams, 0.0) * macroType.caloriesPerGram()
  }
}

extension DFMacroNutrient : Equatable {
  static func ==(lhs: DFMacroNutrient, rhs: DFMacroNutrient) -> Bool {
    return lhs.macroType == rhs.macroType
      && lhs.grams == rhs.grams
  }
}

struct DFNutritionalInfo {
  let servingSize: DFMeasurement
  let fat: DFMacroNutrient
  let protein: DFMacroNutrient
  let carbs: DFMacroNutrient
  let fiber: DFMacroNutrient
  
  init(servingSize: DFMeasurement,
       fat: Float = 0.0,
       protein: Float = 0.0,
       carbs: Float = 0.0,
       fiber: Float = 0.0) {
    self.servingSize = servingSize
    self.fat = DFMacroNutrient(macroType: DFMacroNutrientTypes.fat, grams: fat)
    self.protein = DFMacroNutrient(macroType: DFMacroNutrientTypes.protein, grams: protein)
    self.carbs = DFMacroNutrient(macroType: DFMacroNutrientTypes.carbs, grams: carbs)
    self.fiber = DFMacroNutrient(macroType: DFMacroNutrientTypes.fiber, grams: fiber)
  }
}

extension DFNutritionalInfo : Equatable {
  static func ==(lhs: DFNutritionalInfo, rhs: DFNutritionalInfo) -> Bool {
    return lhs.servingSize == rhs.servingSize
      && lhs.fat == rhs.fat
      && lhs.protein == rhs.protein
      && lhs.carbs == rhs.carbs
      && lhs.fiber == rhs.fiber
  }
}
