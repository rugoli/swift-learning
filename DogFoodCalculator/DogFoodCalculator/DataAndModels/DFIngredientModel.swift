//
//  DFIngredientModel.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientModel: NSObject {
    let ingredientName: String
    let supportedMeasurementUnits: [DFMeasurementUnit]
    let defaultMeasurementUnit: DFMeasurementUnit
    var ingredientAmount: DFMeasurement
    
    required init(ingredientName: String,
                  supportedMeasurementUnits: [DFMeasurementUnit],
                  defaultMeasurementUnit: DFMeasurementUnit? = nil) {
        self.ingredientName = ingredientName
        self.supportedMeasurementUnits = supportedMeasurementUnits
        self.defaultMeasurementUnit = defaultMeasurementUnit != nil ? defaultMeasurementUnit! : self.supportedMeasurementUnits[0]
        self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
        
        super.init()
    }
    
    func selectedMeasurementUnit() -> DFMeasurementUnit {
        return self.ingredientAmount.measurementUnit
    }
    
    func isSelected() -> Bool {
        return self.ingredientAmount.measurementValue > 0
    }
}
