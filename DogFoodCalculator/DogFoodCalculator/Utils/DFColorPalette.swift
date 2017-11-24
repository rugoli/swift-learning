//
//  DFColorPalette.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/23/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

enum DFColorPalette {
  case backgroundColor, ingredientCellBackground
  case measurementUnitSelected, measurementUnitHighlighted
  case borderColor
  case textColor
  
  static func colorForType(_ type: DFColorPalette) -> UIColor {
    switch type {
    case .textColor:
      return UIColor(red: 61/255.0, green: 90/255.0, blue: 128/255.0, alpha: 1.0)
    case .backgroundColor:
      return UIColor.white
    case .ingredientCellBackground:
      return UIColor(red: 247/255.0, green: 244/255.0, blue: 234/255.0, alpha: 1.0)
    case .measurementUnitSelected:
      return UIColor(red: 152/255.0, green: 193/255.0, blue: 217/255.0, alpha: 1.0)
    case .measurementUnitHighlighted:
      return UIColor(red: 152/255.0, green: 193/255.0, blue: 217/255.0, alpha: 0.25)
    case .borderColor:
      return UIColor(red: 188/255.0, green: 196/255.0, blue: 219/255.0, alpha: 1.0)
    }
  }
}
