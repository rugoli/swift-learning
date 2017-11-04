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
    var ingredientAmount: DFMeasurement
    private var defaultMeasurementUnit: DFMeasurementUnit
    private var supportedMeasurementUnits: [DFMeasurementUnit]
    
    required init(ingredientName: String,
                  supportedMeasurementUnits: [DFMeasurementUnit],
                  defaultMeasurementUnit: DFMeasurementUnit? = nil) {
        self.ingredientName = ingredientName
        self.supportedMeasurementUnits = supportedMeasurementUnits
        self.defaultMeasurementUnit = defaultMeasurementUnit != nil ? defaultMeasurementUnit! : self.supportedMeasurementUnits[0]
        self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
        
        super.init()
        
        self.setDefaultAndReorderUnitsIfNecessary()
    }
    
    func setDefaultAndReorderUnitsIfNecessary() {
        if !self.supportedMeasurementUnits.contains(self.defaultMeasurementUnit) {  // default unit not supported, set to first unit
            self.defaultMeasurementUnit = self.supportedMeasurementUnits[0]
            self.ingredientAmount = DFMeasurement(measurementUnit: self.defaultMeasurementUnit, measurementValue: 0)!
        } else if self.supportedMeasurementUnits[0] != self.defaultMeasurementUnit {
            let defaultIndex = self.supportedMeasurementUnits.index(of: self.defaultMeasurementUnit)
            self.supportedMeasurementUnits.remove(at: defaultIndex!)
            self.supportedMeasurementUnits.insert(self.defaultMeasurementUnit, at: 0)
        }
        
        
    }
    
    func selectedMeasurementUnit() -> DFMeasurementUnit {
        return self.ingredientAmount.measurementUnit
    }
    
    func isSelected() -> Bool {
        return self.ingredientAmount.measurementValue > 0
    }
    
    func measurementUnitViewModels() -> [DFMeasurementUnitViewModel] {
        var viewModels = [DFMeasurementUnitViewModel]()
        for unit: DFMeasurementUnit in self.supportedMeasurementUnits {
            viewModels.append(DFMeasurementUnitViewModel(unit: unit, isSelected: unit == self.selectedMeasurementUnit()))
        }
        return viewModels
    }
}

// MARK:

// private var getters

extension DFIngredientModel {
    func getDefaultMeasurementUnit() -> DFMeasurementUnit {
        return self.defaultMeasurementUnit
    }
    
    func getSupportedMesaurementUnits() -> [DFMeasurementUnit] {
        return self.supportedMeasurementUnits
    }
}
