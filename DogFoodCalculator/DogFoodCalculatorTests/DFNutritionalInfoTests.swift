//
//  DFNutritionalInfoTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan on 11/16/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFNutritionalInfoTests: XCTestCase {
    
  func testCalorieCalculations() {
    let noNutrition = DFNutritionalInfo(unit: DFMeasurementUnit.cup)
    do {
      let calories = try noNutrition.calculateCaloriesForMeasurement(measurement: DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: 1.0))
      XCTAssert(calories == 0)
    } catch {
      XCTFail("Test failed because of error: \(error)")
    }
    
    let nutritionalInfo = DFNutritionalInfo(unit: DFMeasurementUnit.tsp, fat: 1.0, protein: 4.0, carbs: 5.0, fiber: 2.0)
    
    // have to break this up because it apparently can't handle all four calculations together
    let numberOfUnits: Float = 2.0
    let fatProteinCals = (1.0 * 9.0 * numberOfUnits + 4.0 * 4 * numberOfUnits) as Float
    let carbsFiberCals = (5.0 * 4 * numberOfUnits + 2.0 * 4 * numberOfUnits) as Float
    do {
      let calories = try nutritionalInfo.calculateCaloriesForMeasurement(measurement: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: numberOfUnits))
      XCTAssert(calories == (fatProteinCals + carbsFiberCals))
    } catch {
      XCTFail("Test failed because of error: \(error)")
    }
  }
  
  func testIncompatibleNutritionalUnit() {
    let nutritionalInfo = DFNutritionalInfo(unit: DFMeasurementUnit.tsp, fat: 1.0, protein: 4.0, carbs: 5.0, fiber: 2.0)
    let invalidUnit: DFMeasurementUnit = DFMeasurementUnit.lb
    
    do {
      _ = try nutritionalInfo.calculateCaloriesForMeasurement(measurement: DFMeasurement(measurementUnit: invalidUnit, measurementValue: 1.0))
      XCTFail("Should not be able to convert from tsp to lb")
    } catch (DFMeasurementConversionError.cannotConvertToUnit) {
      XCTAssert(true)
    } catch {
      XCTFail("Nutritional info calculation failed for unknown reason")
    }
  }
    
}
