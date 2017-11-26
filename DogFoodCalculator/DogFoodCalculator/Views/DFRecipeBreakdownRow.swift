//
//  DFRecipeBreakdownRow.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeBreakdownRow: UIView {
  let rowModel: DFRecipeBreakdownRowViewModel
  
  required init(rowModel: DFRecipeBreakdownRowViewModel) {
    self.rowModel = rowModel
    
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
