//
//  DFAutolayoutHelpers.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/23/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

extension UIView {
  public func constrainEdges(toView view: UIView) {
    let left = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
    let right = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    let bottom = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
    let top = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
    NSLayoutConstraint.activate([left, right, bottom, top])
  }
  
  public func widthConstraint(forWidth width: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
  }
  
  public func heightConstraint(forHeight height: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
  }
  
  public func centerXConstraint(toView view: UIView) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
  }
  
  public func centerYConstraint(toView view: UIView) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
  }
}
