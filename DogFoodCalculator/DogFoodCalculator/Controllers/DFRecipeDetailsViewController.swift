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
    
    self.title = "Recipe"
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(recipe: DFRecipe())
  }
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.white
    let doneNavigationItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetailView))
    self.navigationItem.rightBarButtonItem = doneNavigationItem
  }
  
  @objc private func dismissDetailView() {
    self.dismiss(animated: true, completion: nil)
  }
}
