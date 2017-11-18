//
//  DFIngredientCellViewModel.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientCellViewModel : NSObject {
  let ingredientName: String
  let isSelected: Bool
  private var ingredientAmount: DFMeasurement
  private var defaultMeasurementUnit: DFMeasurementUnit
  private var supportedMeasurementUnits: [DFMeasurementUnit]
  
  required init(_ ingredientModel: DFIngredientModel) {
    
    self.ingredientName = ingredientModel.ingredientName
    self.ingredientAmount = ingredientModel.ingredientAmount
    self.isSelected = ingredientModel.isSelected
    self.defaultMeasurementUnit = ingredientModel.defaultMeasurementUnit
    self.supportedMeasurementUnits = ingredientModel.supportedMeasurementUnits
    
    super.init()
    
    self.validateSupportedAndDefaultUnits()
  }
  
  func measurementUnitViewModels() -> [DFMeasurementUnitViewModel] {
    var viewModels = [DFMeasurementUnitViewModel]()
    for unit: DFMeasurementUnit in self.supportedMeasurementUnits {
      viewModels.append(DFMeasurementUnitViewModel(unit: unit, isSelected: unit == self.selectedMeasurementUnit()))
    }
    return viewModels
  }
  
  func selectedMeasurementUnit() -> DFMeasurementUnit {
    return self.ingredientAmount.measurementUnit
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

// MARK: Data validation

extension DFIngredientCellViewModel {
  private func validateSupportedAndDefaultUnits() {
    self.removeDuplicateMeasurementUnits()
    self.validateDefaultUnits()
  }
  
  private func validateDefaultUnits() {
    if !self.supportedMeasurementUnits.contains(self.defaultMeasurementUnit) {  // default unit not supported, set to first unit
      self.defaultMeasurementUnit = self.supportedMeasurementUnits[0]
      self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)
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

extension DFIngredientCellViewModel {
  func getDefaultMeasurementUnit() -> DFMeasurementUnit {
    return self.defaultMeasurementUnit
  }
  
  func getSupportedMeasurementUnits() -> [DFMeasurementUnit] {
    return self.supportedMeasurementUnits
  }
  
  func getIngredientAmount() -> DFMeasurement {
    return self.ingredientAmount
  }
}

