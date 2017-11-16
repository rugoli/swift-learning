//
//  DFCalculatorViewController
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit
import CoreGraphics

class DFCalculatorViewController: UIViewController {
  private var ingredientListCollectionView: UICollectionView!
  private var ingredientDataSource: DFIngredientCollectionViewDataSource
  
  private var recipeCollectionView: UICollectionView!
  private var recipeDataSource: DFRecipeCollectionViewDataSource
  private var recipe: DFRecipe
  
  required init(coder: NSCoder) {
    self.recipe = DFRecipe()
    self.ingredientDataSource = DFIngredientCollectionViewDataSource()
    self.recipeDataSource = DFRecipeCollectionViewDataSource(withRecipe: self.recipe)
    
    super.init(coder: coder)!
    
    self.recipe.addRecipeUpdateObserver(self)
    self.ingredientDataSource.recipeBuilder = self
    self.recipeDataSource.delegate = self
  }
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.white
    
    self.configureIngredientListCollectionView()
    self.view.addSubview(self.ingredientListCollectionView)
    
    self.configureRecipeCollectionView()
    self.view.addSubview(self.recipeCollectionView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.ingredientListCollectionView?.frame = CGRect(x: 0, y: 50 , width: self.view.bounds.size.width, height: 200)
    self.recipeCollectionView?.frame = CGRect(x: 0, y: 260 , width: self.view.bounds.size.width, height: self.view.bounds.size.height - 260)
  }
  
  deinit {
    self.recipe.removeObserver(self)
  }
  
  private func configureIngredientListCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
    
    self.ingredientListCollectionView = UICollectionView(frame: CGRect(x: 0, y:0 , width: 0, height: 0), collectionViewLayout: flowLayout)
    self.ingredientListCollectionView.backgroundColor = UIColor.white
    self.ingredientListCollectionView.showsHorizontalScrollIndicator = false
    self.ingredientListCollectionView.dataSource = self.ingredientDataSource
    self.ingredientListCollectionView.delegate = self.ingredientDataSource
    self.ingredientListCollectionView.register(DFIngredientsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DFIngredientsCollectionViewCell.reuseIdentifier)
  }
  
  private func configureRecipeCollectionView() {    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.minimumLineSpacing = 10
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
    
    self.recipeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
    self.recipeCollectionView.backgroundColor = UIColor.white
    self.recipeCollectionView.showsHorizontalScrollIndicator = false
    self.recipeCollectionView.dataSource = self.recipeDataSource
    self.recipeCollectionView.delegate = self.recipeDataSource
    self.recipeCollectionView.register(DFRecipeIngredientCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DFRecipeIngredientCollectionViewCell.reuseIdentifier)
  }
}

// MARK: Recipe builder

extension DFCalculatorViewController : DFRecipeBuilder {
  func addIngredient(_ ingredient: DFIngredientModel) {
    self.recipe.addIngredient(ingredient)
  }
  
  func removeIngredient(_ ingredient: DFIngredientModel) {
    self.recipe.removeIngredient(ingredient)
  }
  
  func updateIngredient(oldIngredient: DFIngredientModel, withNewIngredient newIngredient: DFIngredientModel) {
    self.recipe.updateIngredient(oldIngredient: oldIngredient, withNewIngredient: newIngredient)
  }
}

// MARK: Recipe update listener

extension DFCalculatorViewController : DFRecipeUpdateListener {
  func observeRecipeUpdate(notification: NSNotification) {
    let updateModel = notification.userInfo![DFRecipe.notificationUpdateKey] as! DFRecipeUpdateModel
    let indexPaths = [IndexPath(item: updateModel.indexPathRow, section: 0)]
    
    switch updateModel.updateType {
      case .add:
        self.recipeCollectionView.insertItems(at: indexPaths)
      case .remove:
        self.recipeCollectionView.deleteItems(at: indexPaths)
      case .update:
        self.recipeCollectionView.reloadItems(at: indexPaths)
    }
  }
}

// MARK: Recipe collection view delegate

extension DFCalculatorViewController : DFRecipeCollectionViewDelegate {
  func didTapRecipeIngredient(collectionView: UICollectionView, ingredientModel: DFIngredientModel) {
    if let ingredientIndexPath: IndexPath = self.ingredientDataSource.getIndexPathForIngredientModel(ingredientModel) {
      self.ingredientListCollectionView.scrollToItem(at: ingredientIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
  }
}


