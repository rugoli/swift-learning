//
//  DFRecipeBreakdownTable.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeBreakdownTable: UIView {
  let tableRows: [DFRecipeBreakdownRow]
  
  required init(rows: [DFRecipeBreakdownRow]) {
    self.tableRows = rows
    
    super.init(frame: .zero)
    
    for rowView in rows {
      self.addSubview(rowView)
    }
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(rows: [])
  }
}
