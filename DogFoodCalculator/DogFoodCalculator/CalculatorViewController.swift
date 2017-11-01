//
//  CalculatorViewController
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit
import CoreGraphics

class CalculatorViewController: UIViewController {
  private var collectionView: UICollectionView?
  
  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }
  
  override func loadView() {
    super.loadView()
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
    flowLayout.minimumInteritemSpacing = 10
    
    self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
    
    if let collectionView = self.collectionView {
      self.view.addSubview(collectionView)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.collectionView?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
  }
}

