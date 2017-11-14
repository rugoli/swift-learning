//
//  DFIngredientModel.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientModel: NSObject {
  let id: String
  let ingredientName: String
  let ingredientAmount: DFMeasurement
  let isSelected: Bool
  let defaultMeasurementUnit: DFMeasurementUnit
  let supportedMeasurementUnits: [DFMeasurementUnit]
  
  required init(ingredientName: String,
                supportedMeasurementUnits: [DFMeasurementUnit],
                defaultMeasurementUnit: DFMeasurementUnit? = nil,
                isSelected: Bool = false,
                amount: DFMeasurement? = nil) {
    self.ingredientName = ingredientName
    self.id = NSUUID.init().uuidString
    self.supportedMeasurementUnits = supportedMeasurementUnits
    self.defaultMeasurementUnit = defaultMeasurementUnit != nil
      ? defaultMeasurementUnit!
      : self.supportedMeasurementUnits[0]
    self.isSelected = isSelected
    
    self.ingredientAmount = amount != nil
      ? amount!
      : DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
    
    super.init()
  }
  
  func isEffectivelyEqualTo(_ otherModel: DFIngredientModel) -> Bool {
    return self.ingredientName == otherModel.ingredientName
      && self.ingredientAmount == otherModel.ingredientAmount
      && self.isSelected == otherModel.isSelected
      && self.defaultMeasurementUnit == otherModel.defaultMeasurementUnit
      && self.supportedMeasurementUnits == otherModel.supportedMeasurementUnits
  }
}
