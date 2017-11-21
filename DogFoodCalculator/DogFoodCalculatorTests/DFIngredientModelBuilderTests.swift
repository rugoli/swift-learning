//
//  DFIngredientModelBuilderTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan Goli on 11/13/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFIngredientModelBuilderTests: XCTestCase {
    
  func testModelChange() {
    let testModel = DFIngredientModel(ingredientName: "Test",
                                      supportedMeasurementUnits: [DFMeasurementUnit.cup],
                                      nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)),
                                      defaultMeasurementUnit: DFMeasurementUnit.oz)
    
    let newIngredientName = "Test 3"
    let newModel = DFIngredientModelBuilder(fromModel: testModel)
      .withIngredientName(newIngredientName)
      .build()
    XCTAssertFalse(testModel == newModel) // models are no longer the same
    XCTAssertTrue(newModel.ingredientName == newIngredientName) // name has changed
    XCTAssertTrue(testModel.defaultMeasurementUnit == newModel.defaultMeasurementUnit) // another property did not change by accident
    XCTAssertNotNil(testModel.viewModel)  // lazy view model var gets generated
  }
  
  func testNoModelChange() {
    let testModel = DFIngredientModel(ingredientName: "Test",
                                      supportedMeasurementUnits: [DFMeasurementUnit.cup],
                                      nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: 1.0)),
                                      defaultMeasurementUnit: DFMeasurementUnit.oz)
    let newModel = DFIngredientModelBuilder(fromModel: testModel).build()
    XCTAssertTrue(testModel.isEffectivelyEqualTo(newModel))
  }
    
}
