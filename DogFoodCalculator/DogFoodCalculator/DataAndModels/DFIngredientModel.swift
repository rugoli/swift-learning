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
  lazy private var viewModel: DFIngredientCellViewModel = self.generateViewModel()
  
  required init(ingredientName: String,
                supportedMeasurementUnits: [DFMeasurementUnit],
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
  }
  
  private func generateViewModel() -> DFIngredientCellViewModel {
    return DFIngredientCellViewModel(self)
  }
  
  func getViewModel() -> DFIngredientCellViewModel {
    return self.viewModel
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
