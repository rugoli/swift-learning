//
//  DFMeasurementTests.swift
//  DFMeasurementTests
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFMeasurementTests: XCTestCase {
  
  func testAllValidConversions () {
    for convertFromUnit: DFMeasurementUnit in DFMeasurementUnit.allUnits() {
      for convertToUnit: DFMeasurementUnit in convertFromUnit.conversionRatios().keys {
        let oldMeasurement = DFMeasurement(measurementUnit: convertFromUnit, measurementValue: 1.0)
        do {
          let newMeasurement: DFMeasurement? = try oldMeasurement.convertTo(newMeasurementUnit: convertToUnit)
          XCTAssertNotNil(newMeasurement, "Conversion resulted in nil measurement value")
        } catch {
          XCTAssert(false, "Error thrown during conversion: \(error)")
        }
      }
    }
  }
  
  func testAllInvalidConversions () {
    for convertFromUnit: DFMeasurementUnit in DFMeasurementUnit.allUnits() {
      let validConversions = convertFromUnit.conversionRatios()
      let invalidUnits: [DFMeasurementUnit] = DFMeasurementUnit.allUnits().filter {
        validConversions[$0] == nil && $0 != convertFromUnit
      }
      
      for convertToUnit: DFMeasurementUnit in invalidUnits {
        let oldMeasurement = DFMeasurement(measurementUnit: convertFromUnit, measurementValue: 1.0)
        do {
          let _: DFMeasurement? = try oldMeasurement.convertTo(newMeasurementUnit: convertToUnit)
          XCTAssert(false, "Measurement conversion was not valid but error was not thrown")
        } catch DFMeasurementConversionError.cannotConvertToUnit {
          // Expected error was thrown, test passes
        } catch {
          XCTAssert(false, "Error thrown during conversion: \(error)")
        }
      }
    }
  }
  
  func testNegativeMeasurementValue() {
    let measurementUnit = DFMeasurementUnit.cup
    let measurement: DFMeasurement = DFMeasurement(measurementUnit: DFMeasurementUnit.cup, measurementValue: -1.0)
    XCTAssertTrue(measurement == DFMeasurement(measurementUnit: measurementUnit, measurementValue: 0))
  }
  
  func testConvertSameUnit() {
    for unit: DFMeasurementUnit in DFMeasurementUnit.allUnits() {
      let oldMeasurement: DFMeasurement = DFMeasurement(measurementUnit: unit, measurementValue: 1.0)
      do {
        let newMeasurement = try oldMeasurement.convertTo(newMeasurementUnit: unit)
        XCTAssertEqual(oldMeasurement, newMeasurement)
      } catch {
        XCTAssert(false, "Error thrown during conversion: \(error)")
      }
    }
  }
  
  // test that the supported conversions for all measurement units have each defined the reverse conversion
  func testReciprocallyDefinedConversions() {
    for unit: DFMeasurementUnit in DFMeasurementUnit.allUnits() {
      for supportedConversion: DFMeasurementUnit in unit.conversionRatios().keys {
        XCTAssertTrue(supportedConversion.conversionRatios().keys.contains(unit),
                      "\(unit) supports conversion to \(supportedConversion), but \(supportedConversion) does not support conversion back to \(unit)")
      }
    }
  }
  
  /*
   * Make sure to update this test and the allUnits function in the enum
   * whenever a new enum is added to DFMeasurementUnit.
   * THIS TEST WILL NOT BUILD UNLESS THE NEW UNIT IS ADDED
   */
  func testUpdateAllUnitsFunction() {
    let testUnit = DFMeasurementUnit.cup
    switch testUnit {
    case .cup, .lb, .oz, .tbsp, .tsp, .g:
      XCTAssertTrue(true)
    }
  }
}
