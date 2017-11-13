//
//  DFIngredientModelBuilder.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientModelBuilder: NSObject {
  private let id : String
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
  
  func withIngredientAmount(_ amount: DFMeasurement) -> DFIngredientModelBuilder {
    self.ingredientAmount = amount
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
      amount:ingredientAmount)
    return model
  }
}
