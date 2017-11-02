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
    let ingredientAmount: CGFloat
    
    required init(ingredientName: String,
                  supportedMeasurementUnits: [DFMeasurementUnit],
                  ingredientAmount: CGFloat) {
        self.ingredientName = ingredientName
        self.supportedMeasurementUnits = supportedMeasurementUnits
        self.ingredientAmount = ingredientAmount
        
        super.init()
    }
}
