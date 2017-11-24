//
//  DFSupportedMeasurementUnitsRow.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFSupportedMeasurementsProtocol : class {
    func didSelectMeasurementUnit(measurementRow: DFSupportedMeasurementUnitsRow, selectedMeasurement: DFMeasurementUnit)
}

class DFSupportedMeasurementUnitsRow: UIView {
  var supportedMeasurementUnits: [DFMeasurementUnitButtonView]
  weak var delegate: DFSupportedMeasurementsProtocol?
  
  init() {
    self.supportedMeasurementUnits = [DFMeasurementUnitButtonView]()
    
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  private func resetAllButtons() {
    for view: UIView in self.subviews {
      view.removeFromSuperview()
    }
    self.supportedMeasurementUnits.removeAll()
  }
  
  func configureSupportedMeasurementUnits(_ supportedUnits: [DFMeasurementUnitViewModel]) {
    self.resetAllButtons()
    
    for unit: DFMeasurementUnitViewModel in supportedUnits {
      let button: DFMeasurementUnitButtonView = self.buttonForViewModel(unit)
      self.supportedMeasurementUnits.append(button)
      self.addSubview(button)
    }
  }
    
  private func buttonForViewModel(_ viewModel: DFMeasurementUnitViewModel) -> DFMeasurementUnitButtonView {
    let button = DFMeasurementUnitButtonView { [weak self] (_, measurementUnit) in
      self?.delegate?.didSelectMeasurementUnit(measurementRow: self!, selectedMeasurement: measurementUnit)
    }
    button.configureWithViewModel(viewModel: viewModel)
    
    return button
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if self.supportedMeasurementUnits.count == 0 {
      return
    }
    
    for (index, button) in self.supportedMeasurementUnits.enumerated() {
      self.addButtonConstraints(button: button, prevButton: index > 0 ? self.supportedMeasurementUnits[index - 1] : nil)
    }
    
    var edgeConstraints = [NSLayoutConstraint]()
    let firstButton = self.supportedMeasurementUnits[0]
    let lastButton = self.supportedMeasurementUnits.last!
    
    edgeConstraints.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: firstButton, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0))
    edgeConstraints.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: lastButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0))
    NSLayoutConstraint.activate(edgeConstraints)
    
  }
  
  private func addButtonConstraints(button: DFMeasurementUnitButtonView, prevButton: DFMeasurementUnitButtonView?) {
    let cellSize = self.bounds.size
    let buttonSize = button.sizeThatFits(cellSize)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    var constraints = [NSLayoutConstraint]()
    constraints.append(button.centerYConstraint(toView: self))
    constraints.append(button.widthConstraint(forWidth: buttonSize.width))
    constraints.append(button.heightConstraint(forHeight: buttonSize.height))
    if (prevButton != nil) {
      constraints.append(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 10))  // horizontal spacing to previous button
      constraints.append(button.centerYConstraint(toView: prevButton!))  // center vertical alignment to previous button
    }
    NSLayoutConstraint.activate(constraints)
  }
}
