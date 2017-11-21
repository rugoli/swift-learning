//
//  DFIngredientViewModelTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan on 11/3/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFIngredientViewModelTests: XCTestCase {
    
    func testDefaultNotSupported() {
        let firstSupported = DFMeasurementUnit.lb
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test",
                                                                        supportedMeasurementUnits: [firstSupported, DFMeasurementUnit.cup],
                                                                        nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)),
                                                                        defaultMeasurementUnit: DFMeasurementUnit.oz))
        XCTAssertEqual(testViewModel.defaultMeasurementUnit, firstSupported)
    }
    
    func testDefaultNotOrderedFirst() {
        let defaultUnit = DFMeasurementUnit.oz
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test",
                                                                        supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz],
                                                                        nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)),
                                                                        defaultMeasurementUnit: DFMeasurementUnit.oz))
        XCTAssertEqual(testViewModel.supportedMeasurementUnits[0], defaultUnit)
    }
    
    func testDuplicateElements() {
        let duplicateUnit = DFMeasurementUnit.cup
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test",
                                                                        supportedMeasurementUnits: [DFMeasurementUnit.lb, duplicateUnit, DFMeasurementUnit.tsp, duplicateUnit, DFMeasurementUnit.tbsp],
                                                                        nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0))))
        XCTAssertTrue(testViewModel.supportedMeasurementUnits.filter( {$0 == duplicateUnit} ).count == 1, "Duplicate element was not removed")
    }
}
