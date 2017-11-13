//
//  DFCalculatorCollectionViewCell.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFCalculatorCollectionViewCell: UICollectionViewCell {
  private let cellMainLabel: UILabel
  private let supportedUnitsRow: DFSupportedMeasurementUnitsRow
  private let removeIngredientButton : UIButton
  private var ingredientViewModel: DFIngredientCellViewModel!
  var indexPath: IndexPath!
  weak var delegate: DFRecipeBuilder?
  
  static let reuseIdentifier: String = "calculator-cell"
  
  override init(frame: CGRect) {
    cellMainLabel = UILabel()
    cellMainLabel.textColor = UIColor.blue
    cellMainLabel.numberOfLines = 0
    cellMainLabel.textAlignment = NSTextAlignment.center
    cellMainLabel.font = cellMainLabel.font.withSize(18)
    
    supportedUnitsRow = DFSupportedMeasurementUnitsRow()
    
    removeIngredientButton = UIButton(type: UIButtonType.system)
    removeIngredientButton.setTitle("Remove", for: UIControlState.normal)
    removeIngredientButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
    removeIngredientButton.isSelected = false
    removeIngredientButton.isHidden = true
    removeIngredientButton.backgroundColor = UIColor.white
    
    super.init(frame: frame)
    self.backgroundColor = UIColor.white
    self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    supportedUnitsRow.delegate = self
    removeIngredientButton.addTarget(self, action: #selector(self.removeIngredient(sender:)), for: UIControlEvents.touchUpInside)
    
    self.addSubview(removeIngredientButton)
    self.addSubview(cellMainLabel)
    self.addSubview(supportedUnitsRow)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
}

// MARK: Building recipe

extension DFCalculatorCollectionViewCell : DFSupportedMeasurementsProtocol {
  @objc private func removeIngredient(sender: UIButton) {
    delegate?.removeIngredient(ingredientViewModel.ingredientModel)
    
    let newModel = DFIngredientModelBuilder.init(fromModel: self.ingredientViewModel.ingredientModel).withIsSelected(false).build()
    self.ingredientViewModel = DFIngredientCellViewModel.init(newModel)
    delegate?.updateModel(model: self.ingredientViewModel, atIndexPath: self.indexPath)
    
    self.configureCellWithModel(self.ingredientViewModel)
  }
  
  func didSelectMeasurementUnit(measurementRow: DFSupportedMeasurementUnitsRow, selectedMeasurement: DFMeasurementUnit) {
    if self.ingredientViewModel.getIngredientAmount().measurementValue == 0 {  // ingredient not previously added
      self.addIngredientWithNewValue(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0)!)
    } else {
      do {
        let newMeasurementValue = try self.ingredientViewModel.getIngredientAmount().convertTo(newMeasurementUnit: selectedMeasurement)
        self.addIngredientWithNewValue(newMeasurementValue)
        
      } catch {
        self.addIngredientWithNewValue(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0)!)
      }
    }
  }
  
  private func addIngredientWithNewValue(_ newValue: DFMeasurement) {
    let newModel: DFIngredientModel = DFIngredientModelBuilder
      .init(fromModel: self.ingredientViewModel.ingredientModel)
      .withIngredientAmount(newValue)
      .withIsSelected(true)
      .build()
    self.ingredientViewModel = DFIngredientCellViewModel.init(newModel)
    self.delegate?.addIngredient(self.ingredientViewModel.ingredientModel)
    self.configureCellWithModel(self.ingredientViewModel)
  }
}

// MARK: Configuring views and models

extension DFCalculatorCollectionViewCell {
  
  func configureCellWithModel(_ ingredient: DFIngredientCellViewModel) {
    ingredientViewModel = ingredient
    
    self.configureMainLabelProperties()
    self.setMainLabelConstraints()
    
    self.configureSupportedUnitsRow()
    self.setSupportedUnitsRowConstraints()
    
    self.removeIngredientButton.isHidden = !ingredient.isSelected
    self.setRemoveIngredientButtonConstraints()
    
    self.setNeedsLayout()
  }
  
  private func configureMainLabelProperties() {
    cellMainLabel.text = self.ingredientViewModel.ingredientName
  }
  
  private func configureSupportedUnitsRow() {
    supportedUnitsRow.configureSupportedMeasurementUnits(self.ingredientViewModel.measurementUnitViewModels())
  }
}

// MARK: Autolayout constraints

extension DFCalculatorCollectionViewCell {
  private func setMainLabelConstraints() {
    cellMainLabel.removeConstraints(cellMainLabel.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let labelSize: CGSize = cellMainLabel.sizeThatFits(CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: cellSize.height))
    
    cellMainLabel.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topPadding = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
    let width = NSLayoutConstraint(item: cellMainLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.width)
    let height = NSLayoutConstraint(item: cellMainLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: labelSize.height)
    NSLayoutConstraint.activate([centering, topPadding, width, height])
  }
  
  private func setSupportedUnitsRowConstraints() {
    supportedUnitsRow.removeConstraints(supportedUnitsRow.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let rowSize: CGSize = CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: 40)
    
    supportedUnitsRow.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: supportedUnitsRow, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topSpacing = NSLayoutConstraint(item: supportedUnitsRow, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    let height = NSLayoutConstraint(item: supportedUnitsRow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: rowSize.height)
    NSLayoutConstraint.activate([centering, topSpacing, height])
  }
  
  private func setRemoveIngredientButtonConstraints() {
    removeIngredientButton.removeConstraints(removeIngredientButton.constraints)
    let buttonSize = removeIngredientButton.sizeThatFits(self.bounds.size)
    
    removeIngredientButton.translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: removeIngredientButton, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))  // center horizontally with cell
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: supportedUnitsRow, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20))  // 20 pts below supported units row
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.width))  // set width
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.height)) // set height
    NSLayoutConstraint.activate(constraints)
  }
}
