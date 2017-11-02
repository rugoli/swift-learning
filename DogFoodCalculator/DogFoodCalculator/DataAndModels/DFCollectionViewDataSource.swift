//
//  DFCollectionViewDataSource.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10;
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: DFCalculatorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DFCalculatorCollectionViewCell.reuseIdentifier, for: indexPath) as! DFCalculatorCollectionViewCell
    cell.configureCellWithModel(DFIngredientModel(ingredientName: "Ground Turkey 99% Lean", supportedMeasurementUnits: [DFMeasurementUnit.lb, DFMeasurementUnit.oz], ingredientAmount: 1.0))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 150)
  }

}
