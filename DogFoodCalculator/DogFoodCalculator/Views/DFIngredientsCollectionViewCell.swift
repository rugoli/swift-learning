//
//  DFIngredientsCollectionViewCell.swift
//  DogFoodCalculator
//
//  Created by Roshan Goli on 11/1/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFIngredientsCollectionViewCell: UICollectionViewCell {
  private let cellMainLabel: UILabel
  private let supportedUnitsRow: DFSupportedMeasurementUnitsRow
  private let amountTextField: UITextField
  private let removeIngredientButton : UIButton
    
  private var ingredientModel: DFIngredientModel!
  var indexPath: IndexPath!
  weak var delegate: DFIngredientDataSourceAdapterProtocol?
  weak var recipeBuilder: DFRecipeBuilder?
  
  static let reuseIdentifier: String = "ingredient-cell"
  
  override init(frame: CGRect) {
    cellMainLabel = UILabel()
    cellMainLabel.textColor = DFColorPalette.colorForType(.ingredientCellTextColor)
    cellMainLabel.numberOfLines = 0
    cellMainLabel.textAlignment = NSTextAlignment.center
    cellMainLabel.font = UIFont.boldSystemFont(ofSize: 18)
    
    supportedUnitsRow = DFSupportedMeasurementUnitsRow()
    
    amountTextField = UITextField()
    amountTextField.text = "0"
    amountTextField.textColor = DFColorPalette.colorForType(.ingredientCellTextColor)
    amountTextField.font = amountTextField.font?.withSize(24)
    amountTextField.clearsOnBeginEditing = true
    amountTextField.textAlignment = NSTextAlignment.center
    amountTextField.keyboardType = UIKeyboardType.decimalPad
    amountTextField.isHidden = false
    
    removeIngredientButton = UIButton(type: UIButtonType.system)
    removeIngredientButton.setTitle("Remove", for: UIControlState.normal)
    removeIngredientButton.setTitleColor(DFColorPalette.colorForType(.ingredientCellTextColor), for: UIControlState.normal)
    removeIngredientButton.isSelected = false
    removeIngredientButton.isHidden = true
    removeIngredientButton.backgroundColor = UIColor.clear
    
    super.init(frame: frame)
    self.backgroundColor = DFColorPalette.colorForType(.ingredientCellBackground)
    self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    supportedUnitsRow.delegate = self
    amountTextField.delegate = self
    removeIngredientButton.addTarget(self, action: #selector(self.removeIngredient), for: UIControlEvents.touchUpInside)
    
    self.layer.cornerRadius = 5
    
    self.addSubview(cellMainLabel)
    self.addSubview(supportedUnitsRow)
    self.addSubview(amountTextField)
    self.addSubview(removeIngredientButton)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
  }
}

// MARK: Recipe building

extension DFIngredientsCollectionViewCell : DFSupportedMeasurementsProtocol {
  func didSelectMeasurementUnit(measurementRow: DFSupportedMeasurementUnitsRow, selectedMeasurement: DFMeasurementUnit) {
    if self.ingredientModel.viewModel.ingredientAmount.measurementValue == 0 {  // ingredient not previously added
      self.addIngredientWithNewValue(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0))
    } else {
      do {
        let newMeasurementValue = try self.ingredientModel.viewModel.ingredientAmount.convertTo(newMeasurementUnit: selectedMeasurement)
        self.changeIngredientAmount(newMeasurementValue)
        
      } catch {
        self.changeIngredientAmount(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0))
      }
    }
  }
  
  @objc private func removeIngredient() {
    self.recipeBuilder?.removeIngredient(self.ingredientModel)
    
    let newModel = DFIngredientModelBuilder(fromModel: self.ingredientModel)
      .withResetIngredientValues()
      .build()
    
    self.updateDataSourceAndCell(withNewModel: newModel)
  }
  
  private func changeIngredientAmount(_ newValue: DFMeasurement) {
    let newModel: DFIngredientModel =
      DFIngredientModelBuilder(fromModel: self.ingredientModel)
        .withIngredientMeasurement(newValue)
        .build()
    self.recipeBuilder?.updateIngredient(oldIngredient: self.ingredientModel, withNewIngredient: newModel)
    self.updateDataSourceAndCell(withNewModel: newModel)
  }
  
  private func addIngredientWithNewValue(_ newValue: DFMeasurement) {
    let newModel: DFIngredientModel =
      DFIngredientModelBuilder(fromModel: self.ingredientModel)
      .withIngredientMeasurement(newValue)
      .withIsSelected(true)
      .build()
    self.updateDataSourceAndCell(withNewModel: newModel)
    self.recipeBuilder?.addIngredient(self.ingredientModel)
  }
  
  private func updateDataSourceAndCell(withNewModel newModel: DFIngredientModel) {
    self.ingredientModel = newModel
    self.delegate?.updateModel(model: self.ingredientModel, atIndexPath: self.indexPath)
    self.configureCellWithModel(self.ingredientModel)
  }
}

// MARK: Text field delegate

extension DFIngredientsCollectionViewCell : UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowableCharacterSet = NSCharacterSet(charactersIn: "0123456789.")
    
    guard allowableCharacterSet.isSuperset(of: NSCharacterSet(charactersIn: string) as CharacterSet) else {
      return false
    }
    
    if string.contains(".") {
      guard !(textField.text?.contains("."))! else {
        return false
      }
    }
    
    return true
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    let input = textField.text
    guard input != nil &&  input!.count > 0 else {  // do nothing if text field is empty or nil
      self.configureAmountTextFieldProperties()
      return
    }
    
    let newIngredientAmount = DFMeasurement(measurementUnit: self.ingredientModel.viewModel.ingredientAmount.measurementUnit,
                                            measurementValue: (input as! NSString).floatValue)
    guard newIngredientAmount.measurementValue > 0 else {  // remove ingredient if text is not greater than zero
      self.removeIngredient()
      return
    }
    
    if self.ingredientModel.viewModel.ingredientAmount.measurementValue > 0 {
      self.changeIngredientAmount(newIngredientAmount)
    } else {
      self.addIngredientWithNewValue(newIngredientAmount)
    }
  }
}

// MARK: Configuring views and models

extension DFIngredientsCollectionViewCell {
  
  func configureCellWithModel(_ ingredient: DFIngredientModel) {
    self.ingredientModel = ingredient
    
    self.configureMainLabelProperties()
    self.setMainLabelConstraints()
    
    self.configureSupportedUnitsRow()
    self.setSupportedUnitsRowConstraints()
    
    self.configureAmountTextFieldProperties()
    self.setAmountTextFieldConstraints()
    
    self.removeIngredientButton.isHidden = !ingredient.isSelected
    self.setRemoveIngredientButtonConstraints()
    
    self.setNeedsLayout()
  }
  
  private func configureMainLabelProperties() {
    cellMainLabel.text = self.ingredientModel.viewModel.ingredientName
  }
  
  private func configureSupportedUnitsRow() {
    supportedUnitsRow.configureSupportedMeasurementUnits(self.ingredientModel.viewModel.measurementUnitViewModels())
  }
  
  private func configureAmountTextFieldProperties() {
    let amountValue = self.ingredientModel.viewModel.ingredientAmount.measurementValue
    self.amountTextField.text = "\(amountValue)"
  }
}

// MARK: Autolayout constraints

extension DFIngredientsCollectionViewCell {
  private func setMainLabelConstraints() {
    cellMainLabel.removeConstraints(cellMainLabel.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let labelSize: CGSize = cellMainLabel.sizeThatFits(CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: cellSize.height))
    
    cellMainLabel.translatesAutoresizingMaskIntoConstraints = false
    let topPadding = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
    let centering = cellMainLabel.centerXConstraint(toView: self)
    let width = cellMainLabel.widthConstraint(forWidth: labelSize.width)
    let height = cellMainLabel.heightConstraint(forHeight: labelSize.height)
    NSLayoutConstraint.activate([centering, topPadding, width, height])
  }
  
  private func setSupportedUnitsRowConstraints() {
    supportedUnitsRow.removeConstraints(supportedUnitsRow.constraints)
    
    let cellSize = self.bounds.size
    let cellMargins = self.layoutMargins
    let rowSize: CGSize = CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: 40)
    
    supportedUnitsRow.translatesAutoresizingMaskIntoConstraints = false
    let centering = supportedUnitsRow.centerXConstraint(toView: self)
    let topSpacing = NSLayoutConstraint(item: supportedUnitsRow, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    let height = supportedUnitsRow.heightConstraint(forHeight: rowSize.height)
    NSLayoutConstraint.activate([centering, topSpacing, height])
  }
  
  private func setAmountTextFieldConstraints() {
    amountTextField.removeConstraints(amountTextField.constraints)
    let textFieldSize = amountTextField.sizeThatFits(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
    
    amountTextField.translatesAutoresizingMaskIntoConstraints = false
    let centering = amountTextField.centerXConstraint(toView: self)
    let topSpacing = NSLayoutConstraint(item: amountTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: supportedUnitsRow, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    let width = amountTextField.widthConstraint(forWidth: textFieldSize.width)
    let height = amountTextField.heightConstraint(forHeight: textFieldSize.height)
    NSLayoutConstraint.activate([centering, topSpacing, height, width])
  }
  
  private func setRemoveIngredientButtonConstraints() {
    removeIngredientButton.removeConstraints(removeIngredientButton.constraints)
    let buttonSize = removeIngredientButton.sizeThatFits(self.bounds.size)
    
    removeIngredientButton.translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    constraints.append(removeIngredientButton.centerXConstraint(toView: self))  // center horizontally with cell
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: amountTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5))  // 5 pts below amount text field row
    constraints.append(removeIngredientButton.widthConstraint(forWidth: buttonSize.width))
    constraints.append(removeIngredientButton.heightConstraint(forHeight: buttonSize.height))
    NSLayoutConstraint.activate(constraints)
  }
}
