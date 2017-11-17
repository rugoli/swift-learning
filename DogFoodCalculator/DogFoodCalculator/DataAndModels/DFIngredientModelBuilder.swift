//
//  DFIngredientModelBuilder.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientModelBuilder: NSObject {
  private var id: String
  private var ingredientName: String
  private var ingredientAmount: DFMeasurement
  private var isSelected: Bool
  private var defaultMeasurementUnit: DFMeasurementUnit
  private var supportedMeasurementUnits: [DFMeasurementUnit]
  
  required init(fromModel model: DFIngredientModel) {
    self.id = model.id
    self.ingredientName = model.ingredientName
    self.ingredientAmount = model.ingredientAmount
    self.isSelected = model.isSelected
    self.defaultMeasurementUnit = model.defaultMeasurementUnit
    self.supportedMeasurementUnits = model.supportedMeasurementUnits
    
    super.init()
  }
  
  func withIngredientName(_ ingredientName : String) -> DFIngredientModelBuilder {
    self.ingredientName = ingredientName
    return self
  }
  
  func withIngredientMeasurement(_ measurement: DFMeasurement) -> DFIngredientModelBuilder {
    self.ingredientAmount = measurement
    return self
  }
  
  func withIsSelected(_ isSelected: Bool) -> DFIngredientModelBuilder {
    self.isSelected = isSelected
    return self
  }
  
  func withDefaultMeasurementUnit(_ defaultUnit : DFMeasurementUnit) -> DFIngredientModelBuilder {
    self.defaultMeasurementUnit = defaultUnit
    return self
  }
  
  func withSupportedMeasurementUnits(_ supportedUnits: [DFMeasurementUnit]) -> DFIngredientModelBuilder {
    self.supportedMeasurementUnits = supportedUnits
    return self
  }
  
  func build() -> DFIngredientModel {
    let model: DFIngredientModel = DFIngredientModel(
      ingredientName: ingredientName, supportedMeasurementUnits: supportedMeasurementUnits,
      defaultMeasurementUnit: defaultMeasurementUnit,
      isSelected: isSelected,
      amount:ingredientAmount,
      id: id)
    return model
  }
}

// MARK: convenience methods

extension DFIngredientModelBuilder {
  func withNewIngredientAmount(_ amount: Float) -> DFIngredientModelBuilder {
    self.ingredientAmount = DFMeasurement(measurementUnit: self.ingredientAmount.measurementUnit, measurementValue: amount)
    return self
  }
  
  func withResetIngredientValues() -> DFIngredientModelBuilder {
    return self.withNewIngredientAmount(0)
      .withIsSelected(false)
  }
}
