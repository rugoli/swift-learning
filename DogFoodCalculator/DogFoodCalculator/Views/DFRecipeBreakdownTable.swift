//
//  DFRecipeBreakdownTable.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/25/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFRecipeBreakdownTable: UIView {
  let tableRows: [DFRecipeBreakdownRowView]
  let nameLabelWidth: CGFloat = 250
  let percentageLabelWidth: CGFloat = 75
  
  required init(rows: [DFRecipeBreakdownRowViewModel]) {
    self.tableRows = DFRecipeBreakdownTable.generateRowViewsFromModels(viewModels: rows)
    
    super.init(frame: .zero)
    
    for row in self.tableRows {
      self.addSubview(row)
    }
    
    self.setAutolayoutConstraints()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(rows: [])
  }
  
  private func setAutolayoutConstraints() {
    guard self.tableRows.count > 0 else { return }
    
    var prevRow: DFRecipeBreakdownRowView? = nil
    for row in self.tableRows {
      self.setRowAutolayout(row: row, previousRow: prevRow)

      prevRow = row
    }
    
    NSLayoutConstraint.activate([NSLayoutConstraint(item: self.tableRows.first!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)])
    NSLayoutConstraint.activate([NSLayoutConstraint(item: self.tableRows.last!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)])
    
  }
  
  private func setRowAutolayout(row: DFRecipeBreakdownRowView, previousRow: DFRecipeBreakdownRowView?) {
    row.removeConstraints(row.constraints)
    row.translatesAutoresizingMaskIntoConstraints = false
    let nameLabelSize = row.breakdownName.sizeThatFits(CGSize(width: self.nameLabelWidth, height: 100))
    
    let leftAnchor = row.constraintPaddingForDirection(padding: 0, direction: .left, toView: self)
    let nameLabelWidth = row.breakdownName.widthConstraint(forWidth: self.nameLabelWidth)
    let percentageLabelWidth = row.percentage.widthConstraint(forWidth: self.percentageLabelWidth)
    let rowHeightConstraint = row.heightConstraint(forHeight: nameLabelSize.height)
    let rowWidth = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: row, attribute: .width, multiplier: 1.0, constant: 0)
    
    NSLayoutConstraint.activate([leftAnchor, nameLabelWidth, percentageLabelWidth, rowHeightConstraint, rowWidth])
    
    if (previousRow != nil) {
      NSLayoutConstraint.activate([NSLayoutConstraint(item: row, attribute: .top, relatedBy: .equal, toItem: previousRow!, attribute: .bottom, multiplier: 1.0, constant: 10)])
    }
    
    row.setRowAlignmentConstraints()
  }
  
  static private func generateRowViewsFromModels(viewModels: [DFRecipeBreakdownRowViewModel]) -> [DFRecipeBreakdownRowView] {
    var rowViews = [DFRecipeBreakdownRowView]()
    for viewModel: DFRecipeBreakdownRowViewModel in viewModels {
      rowViews.append(DFRecipeBreakdownRowView(viewModel: viewModel))
    }
    return rowViews
  }
}
