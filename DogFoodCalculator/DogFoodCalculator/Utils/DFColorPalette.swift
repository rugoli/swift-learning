//
//  DFColorPalette.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/23/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

enum DFColorPalette {
  case backgroundColor
  case recipeCellBackground, recipeCellHighlighted, recipeCellText
  case measurementUnitSelected, measurementUnitHighlighted
  case ingredientCellTextColor, ingredientCellBackground
  case calorieCounterText, calorieCounterBackground
  case recipeDetailsViewBackground
  
  static func colorForType(_ type: DFColorPalette) -> UIColor {
    switch type {
    case .backgroundColor:
      return UIColor.white
      
    // measurement units
    case .measurementUnitSelected:
      return self.darkBlueColorWithAlpha(1.0)
    case .measurementUnitHighlighted:
      return self.darkBlueColorWithAlpha(0.5)
      
    // ingredient cell
    case .ingredientCellBackground:
      return self.lightBlueColor()
    case .ingredientCellTextColor:
      return UIColor.white
      
    // recipe cell
    case .recipeCellBackground:
      return self.tanColorWithAlpha(1.0)
    case .recipeCellHighlighted:
      return self.tanColorWithAlpha(0.75)
    case .recipeCellText:
      return UIColor.black
      
    // calorie counter
    case .calorieCounterText:
      return self.darkBlueColorWithAlpha(1.0)
    case .calorieCounterBackground:
      return self.beigeColor()
      
    // recipe details view
    case .recipeDetailsViewBackground:
      return self.beigeColor()
    }
    
  }
  
  static private func darkBlueColorWithAlpha(_ alpha: CGFloat) -> UIColor {
    return UIColor(red: 61/255.0, green: 90/255.0, blue: 128/255.0, alpha: alpha)
  }
  
  static private func tanColorWithAlpha(_ alpha: CGFloat) -> UIColor {
    return UIColor(red: 237/255.0, green: 217/255.0, blue: 183/255.0, alpha: alpha)
  }
  
  static private func lightBlueColor() -> UIColor {
    return UIColor(red: 152/255.0, green: 193/255.0, blue: 217/255.0, alpha: 1.0)
  }
  
  static private func beigeColor() -> UIColor {
    return UIColor(red: 247/255.0, green: 244/255.0, blue: 234/255.0, alpha: 1.0)
  }
}
