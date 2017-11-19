//
//  DFMeasurement.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

enum DFMeasurementConversionError: Error {
    case cannotConvertToUnit
}

enum DFMeasurementUnit: String {
    case tsp = "tsp"
    case tbsp = "tbsp"
    case cup = "cup"
    case lb = "lb"
    case oz = "oz"
    case g = "g"
    
    func conversionRatios() -> [DFMeasurementUnit: Float] {
        switch self {
          case .tsp:
            return [
              DFMeasurementUnit.tbsp: 3.0,
              DFMeasurementUnit.cup: 48.0,
            ]
          case .tbsp:
            return [
              DFMeasurementUnit.tsp: 1.0/3.0,
              DFMeasurementUnit.cup: 16.0,
            ]
          case .cup:
            return [
              DFMeasurementUnit.tsp: 1.0/48.0,
              DFMeasurementUnit.tbsp: 1.0/16.0,
            ]
          case .lb:
            return [
              DFMeasurementUnit.oz: 1.0/16.0,
              DFMeasurementUnit.g: 1.0/453.59,
            ]
          case .oz:
            return [
              DFMeasurementUnit.lb: 16.0,
              DFMeasurementUnit.g: 1.0/28.35,
          ]
          case .g:
            return [
              DFMeasurementUnit.lb: 453.59,
              DFMeasurementUnit.oz: 28.35,
            ]
        }
    }
    
    static func allUnits() -> [DFMeasurementUnit] {
        return [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp, DFMeasurementUnit.cup, DFMeasurementUnit.lb, DFMeasurementUnit.oz, DFMeasurementUnit.g]
    }
}

struct DFMeasurementUnitViewModel {
    let measurementUnit: DFMeasurementUnit
    let isSelected: Bool
    
    init(unit: DFMeasurementUnit, isSelected: Bool) {
        self.measurementUnit = unit
        self.isSelected = isSelected
    }
}

struct DFMeasurement {
  var measurementUnit: DFMeasurementUnit
  var measurementValue: Float
  
  init(measurementUnit: DFMeasurementUnit, measurementValue: Float) {
    self.measurementUnit = measurementUnit
    self.measurementValue = measurementValue >= 0 ? measurementValue : 0
  }
  
  func convertTo(newMeasurementUnit: DFMeasurementUnit) throws -> DFMeasurement {
    if newMeasurementUnit == measurementUnit {
      return self
    } else if let conversion = measurementUnit.conversionRatios()[newMeasurementUnit] {
      return DFMeasurement(measurementUnit: newMeasurementUnit, measurementValue: measurementValue / conversion)
    } else if let reverseConversion = newMeasurementUnit.conversionRatios()[measurementUnit] {
      return DFMeasurement(measurementUnit: newMeasurementUnit, measurementValue: measurementValue * reverseConversion)
    }
    throw DFMeasurementConversionError.cannotConvertToUnit
  }
  
  func prettyPrint() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    return "\(formatter.string(from: NSNumber.init(value: self.measurementValue))!) \(self.measurementUnit)"
  }
}

extension DFMeasurement : Equatable {
    static func ==(lhs: DFMeasurement, rhs: DFMeasurement) -> Bool {
        return lhs.measurementUnit == rhs.measurementUnit
            && lhs.measurementValue == rhs.measurementValue
    }
}
