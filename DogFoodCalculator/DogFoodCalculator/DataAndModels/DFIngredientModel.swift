//
//  DFIngredientModel.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientModel: NSObject {
  let ingredientName: String
  var ingredientAmount: DFMeasurement
  var isSelected: Bool
  private var defaultMeasurementUnit: DFMeasurementUnit
  private var supportedMeasurementUnits: [DFMeasurementUnit]
  
  required init(ingredientName: String,
                supportedMeasurementUnits: [DFMeasurementUnit],
                defaultMeasurementUnit: DFMeasurementUnit? = nil,
                isSelected: Bool = false) {
    self.ingredientName = ingredientName
    self.supportedMeasurementUnits = supportedMeasurementUnits
    self.defaultMeasurementUnit = defaultMeasurementUnit != nil ? defaultMeasurementUnit! : self.supportedMeasurementUnits[0]
    self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
    self.isSelected = isSelected
    
    super.init()
    
    self.validateSupportedAndDefaultUnits()
  }
}

// MARK: Data validation

extension DFIngredientModel {
  private func validateSupportedAndDefaultUnits() {
    self.removeDuplicateMeasurementUnits()
    self.validateDefaultUnits()
  }
  
  private func validateDefaultUnits() {
    if !self.supportedMeasurementUnits.contains(self.defaultMeasurementUnit) {  // default unit not supported, set to first unit
      self.defaultMeasurementUnit = self.supportedMeasurementUnits[0]
      self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
    } else if self.supportedMeasurementUnits[0] != self.defaultMeasurementUnit {  // default unit not listed first
      let defaultIndex = self.supportedMeasurementUnits.index(of: self.defaultMeasurementUnit)
      self.supportedMeasurementUnits.remove(at: defaultIndex!)
      self.supportedMeasurementUnits.insert(self.defaultMeasurementUnit, at: 0)
    }
  }
  
  private func removeDuplicateMeasurementUnits() {
    var i : Int = 0
    while i < self.supportedMeasurementUnits.count {
      if self.supportedMeasurementUnits[..<i].contains(self.supportedMeasurementUnits[i]) {
        self.supportedMeasurementUnits.remove(at: i)
      } else {
        i += 1
      }
    }
  }
}

// MARK: Private var getters

extension DFIngredientModel {
  func getDefaultMeasurementUnit() -> DFMeasurementUnit {
    return self.defaultMeasurementUnit
  }
  
  func getSupportedMeasurementUnits() -> [DFMeasurementUnit] {
    return self.supportedMeasurementUnits
  }
}
