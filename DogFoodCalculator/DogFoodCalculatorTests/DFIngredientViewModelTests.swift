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
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [firstSupported, DFMeasurementUnit.cup], defaultMeasurementUnit: DFMeasurementUnit.oz))
        XCTAssertEqual(testViewModel.getDefaultMeasurementUnit(), firstSupported)
    }
    
    func testDefaultNotOrderedFirst() {
        let defaultUnit = DFMeasurementUnit.oz
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.oz))
        XCTAssertEqual(testViewModel.getSupportedMeasurementUnits()[0], defaultUnit)
    }
    
    func testDuplicateElements() {
        let duplicateUnit = DFMeasurementUnit.cup
        let testViewModel = DFIngredientCellViewModel(DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [DFMeasurementUnit.lb, duplicateUnit, DFMeasurementUnit.tsp, duplicateUnit, DFMeasurementUnit.tbsp]))
        XCTAssertTrue(testViewModel.getSupportedMeasurementUnits().filter( {$0 == duplicateUnit} ).count == 1, "Duplicate element was not removed")
    }
}
