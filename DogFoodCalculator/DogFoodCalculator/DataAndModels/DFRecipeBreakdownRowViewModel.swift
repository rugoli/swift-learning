//
//  DFRecipeBreakdownRowViewModel.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeBreakdownRowViewModel: NSObject {
  let name: String
  let percentage: Float
  
  required init(name: String,
                percentage: Float) {
    self.name = name
    self.percentage = percentage
    
    super.init()
  }
}
