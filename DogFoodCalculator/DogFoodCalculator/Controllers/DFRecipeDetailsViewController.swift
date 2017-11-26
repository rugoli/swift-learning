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
  private var recipeDetailsView: DFRecipeDetailsView!

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
    
    self.recipeDetailsView = DFRecipeDetailsView(recipe: self.recipe, doneButtonAction: { [weak self] in
      self?.dismiss(animated: true, completion: nil)
    })
    self.view.addSubview(self.recipeDetailsView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    self.recipeDetailsView.frame = self.view.bounds
    self.recipeDetailsView.setAllConstraints()
  }
}
