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
  private var collectionView: UICollectionView!
  private var dataSource: DFIngredientCollectionViewDataSource!
  
  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.white
    
    self.dataSource = DFIngredientCollectionViewDataSource.init()
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
    
    self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
    self.collectionView.backgroundColor = UIColor.black
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.dataSource = self.dataSource
    self.collectionView.delegate = self.dataSource
    self.collectionView.register(DFCalculatorCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DFCalculatorCollectionViewCell.reuseIdentifier)
    self.view.addSubview(self.collectionView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.collectionView?.frame = CGRect(x: 0, y: 50 , width: self.view.bounds.size.width, height: 200)
  }
}

