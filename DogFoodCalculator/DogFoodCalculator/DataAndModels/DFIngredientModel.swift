//
//  DFIngredientModel.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

struct DFMacroCalories {
  let macroType: DFMacroNutrientTypes
  var calories: Float
  
  func withMoreCalories(_ moreCalories: Float) -> DFMacroCalories {
    return DFMacroCalories(macroType: macroType, calories: calories + moreCalories)
  }
}

class DFIngredientModel: NSObject {
  let id: String
  let ingredientName: String
  let ingredientAmount: DFMeasurement
  let isSelected: Bool
  let defaultMeasurementUnit: DFMeasurementUnit
  let supportedMeasurementUnits: [DFMeasurementUnit]
  let nutritionalInfo: DFNutritionalInfo
  lazy public private(set) var viewModel: DFIngredientCellViewModel = self.generateViewModel()
  
  required init(ingredientName: String,
                supportedMeasurementUnits: [DFMeasurementUnit],
                nutritionalInfo: DFNutritionalInfo,
                defaultMeasurementUnit: DFMeasurementUnit? = nil,
                isSelected: Bool = false,
                amount: DFMeasurement? = nil,
                id: String = NSUUID.init().uuidString) {
    self.ingredientName = ingredientName
    self.id = id
    self.supportedMeasurementUnits = supportedMeasurementUnits
    self.defaultMeasurementUnit = defaultMeasurementUnit != nil
      ? defaultMeasurementUnit!
      : self.supportedMeasurementUnits[0]
    self.isSelected = isSelected
    self.nutritionalInfo = nutritionalInfo
    
    self.ingredientAmount = amount != nil
      ? amount!
      : DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)
    
    super.init()
  }
  
  func isEffectivelyEqualTo(_ otherModel: DFIngredientModel) -> Bool {
    return self.ingredientName == otherModel.ingredientName
      && self.ingredientAmount == otherModel.ingredientAmount
      && self.isSelected == otherModel.isSelected
      && self.defaultMeasurementUnit == otherModel.defaultMeasurementUnit
      && self.supportedMeasurementUnits == otherModel.supportedMeasurementUnits
      && self.nutritionalInfo == otherModel.nutritionalInfo
  }
  
  private func generateViewModel() -> DFIngredientCellViewModel {
    return DFIngredientCellViewModel(self)
  }
  
  override var description : String {
    return
      """
        Ingredient Name: \(self.ingredientName)\n
        Ingredient Amount: \(self.ingredientAmount)\n
        Is Selected: \(self.isSelected)\n
        Default unit: \(self.defaultMeasurementUnit)\n
        Supported Units: \(self.supportedMeasurementUnits)
      """
  }
}

// MARK : Calorie calculations

extension DFIngredientModel {
  func ingredientCalories(measurement: DFMeasurement? = nil) -> Float {
    let newMeasurement = measurement ?? ingredientAmount
    let macroBreakdown = self.caloriesForMeasurementByMacro(amount: newMeasurement).map { (_, value) in
      value
    }
    
    return macroBreakdown.reduce(0.0, { totalCalories, macroCalories in
      totalCalories + macroCalories.calories
    })
  }
  
  func caloriesForMeasurementByMacro(amount: DFMeasurement? = nil) -> [DFMacroNutrientTypes : DFMacroCalories] {
    let measurement = amount ?? ingredientAmount
    var macroMap: [DFMacroNutrientTypes: DFMacroCalories] = [:]
    _ = DFMacroNutrientTypes.allTypes().map { macroType -> Void in
      do {
        let newMeasurement = try measurement.convertTo(newMeasurementUnit: self.nutritionalInfo.servingSize.measurementUnit)
        macroMap[macroType] = DFMacroCalories(macroType: macroType, calories: (newMeasurement.measurementValue / self.nutritionalInfo.servingSize.measurementValue) * caloriesForMacroType(macroType: macroType))
      } catch {
        macroMap[macroType] = DFMacroCalories(macroType: macroType, calories: 0.0)
      }
    }
    
    return macroMap
  }
  
  private func caloriesForMacroType(macroType : DFMacroNutrientTypes) -> Float {
    switch macroType {
    case .fat: return self.nutritionalInfo.fat.calories()
    case .carbs: return self.nutritionalInfo.carbs.calories()
    case .protein: return self.nutritionalInfo.protein.calories()
    case .fiber: return self.nutritionalInfo.fiber.calories()
    }
  }
}
