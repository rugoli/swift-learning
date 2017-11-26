//
//  DFRecipeDetailsViewController.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeDetailsViewController: UIViewController {
  let recipe: DFRecipe

  required init(recipe: DFRecipe) {
    self.recipe = recipe
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(recipe: DFRecipe())
  }
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.red
  }

}
