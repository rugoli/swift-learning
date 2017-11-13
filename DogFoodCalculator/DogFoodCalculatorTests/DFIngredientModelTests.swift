//
//  DFIngredientModelTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan on 11/3/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFIngredientModelTests: XCTestCase {
    
    func testDefaultNotSupported() {
        let firstSupported = DFMeasurementUnit.lb
        let testIngredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [firstSupported, DFMeasurementUnit.cup], defaultMeasurementUnit: DFMeasurementUnit.oz)
        XCTAssertEqual(testIngredient.getDefaultMeasurementUnit(), firstSupported)
    }
    
    func testDefaultNotOrderedFirst() {
        let defaultUnit = DFMeasurementUnit.oz
        let testIngredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], defaultMeasurementUnit: DFMeasurementUnit.oz)
        XCTAssertEqual(testIngredient.getSupportedMeasurementUnits()[0], defaultUnit)
    }
    
    func testDuplicateElements() {
        let duplicateUnit = DFMeasurementUnit.cup
        let testIngredient = DFIngredientModel(ingredientName: "Test", supportedMeasurementUnits: [DFMeasurementUnit.lb, duplicateUnit, DFMeasurementUnit.tsp, duplicateUnit, DFMeasurementUnit.tbsp])
        XCTAssertTrue(testIngredient.getSupportedMeasurementUnits().filter( {$0 == duplicateUnit} ).count == 1, "Duplicate element was not removed")
    }
}
