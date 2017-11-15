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
    
  private var ingredientViewModel: DFIngredientCellViewModel!
  var indexPath: IndexPath!
  weak var delegate: DFDataSourceAdapterProtocol?
  weak var recipeBuilder: DFRecipeBuilder?
  
  static let reuseIdentifier: String = "ingredient-cell"
  
  override init(frame: CGRect) {
    cellMainLabel = UILabel()
    cellMainLabel.textColor = UIColor.blue
    cellMainLabel.numberOfLines = 0
    cellMainLabel.textAlignment = NSTextAlignment.center
    cellMainLabel.font = cellMainLabel.font.withSize(18)
    
    supportedUnitsRow = DFSupportedMeasurementUnitsRow()
    
    amountTextField = UITextField()
    amountTextField.text = "0"
    amountTextField.font = amountTextField.font?.withSize(24)
    amountTextField.clearsOnBeginEditing = true
    amountTextField.textAlignment = NSTextAlignment.center
    amountTextField.keyboardType = UIKeyboardType.decimalPad
    amountTextField.isHidden = false
    
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
    amountTextField.delegate = self
    removeIngredientButton.addTarget(self, action: #selector(self.removeIngredient), for: UIControlEvents.touchUpInside)
    
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.blue.cgColor
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    
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
    if self.ingredientViewModel.getIngredientAmount().measurementValue == 0 {  // ingredient not previously added
      self.addIngredientWithNewValue(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0))
    } else {
      do {
        let newMeasurementValue = try self.ingredientViewModel.getIngredientAmount().convertTo(newMeasurementUnit: selectedMeasurement)
        self.changeIngredientAmount(newMeasurementValue)
        
      } catch {
        self.changeIngredientAmount(DFMeasurement(measurementUnit: selectedMeasurement, measurementValue: 1.0))
      }
    }
  }
  
  @objc private func removeIngredient() {
    self.recipeBuilder?.removeIngredient(ingredientViewModel.ingredientModel)
    
    let newModel = DFIngredientModelBuilder(fromModel: self.ingredientViewModel.ingredientModel)
      .withIsSelected(false)
      .withNewIngredientAmount(0)
      .build()
    
    self.updateDataSourceAndCell(withNewViewModel: DFIngredientCellViewModel(newModel))
  }
  
  private func changeIngredientAmount(_ newValue: DFMeasurement) {
    let newModel: DFIngredientModel =
      DFIngredientModelBuilder(fromModel: self.ingredientViewModel.ingredientModel)
        .withIngredientMeasurement(newValue)
        .build()
    self.recipeBuilder?.updateIngredient(oldIngredient: self.ingredientViewModel.ingredientModel, withNewIngredient: newModel)
    self.updateDataSourceAndCell(withNewViewModel: DFIngredientCellViewModel(newModel))
  }
  
  private func addIngredientWithNewValue(_ newValue: DFMeasurement) {
    let newModel: DFIngredientModel =
      DFIngredientModelBuilder(fromModel: self.ingredientViewModel.ingredientModel)
      .withIngredientMeasurement(newValue)
      .withIsSelected(true)
      .build()
    self.updateDataSourceAndCell(withNewViewModel: DFIngredientCellViewModel(newModel))
    self.recipeBuilder?.addIngredient(self.ingredientViewModel.ingredientModel)
  }
  
  private func updateDataSourceAndCell(withNewViewModel newModel: DFIngredientCellViewModel) {
    self.ingredientViewModel = newModel
    self.delegate?.updateModel(model: self.ingredientViewModel, atIndexPath: self.indexPath)
    self.configureCellWithModel(self.ingredientViewModel)
  }
}

// MARK : Gesture recognizer

extension DFIngredientsCollectionViewCell {
  @objc private func dismissKeyboard() {
    self.endEditing(true)
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
    guard let input = textField.text else {  // remove ingredient if text is nil
      self.removeIngredient()
      return
    }
    
    let newIngredientAmount = DFMeasurement(measurementUnit: self.ingredientViewModel.getIngredientAmount().measurementUnit,
                                            measurementValue: (input as NSString).floatValue)
    guard newIngredientAmount.measurementValue > 0 else {  // remove ingredient if text is not greater than zero
      self.removeIngredient()
      return
    }
    
    if self.ingredientViewModel.getIngredientAmount().measurementValue > 0 {
      self.changeIngredientAmount(newIngredientAmount)
    } else {
      self.addIngredientWithNewValue(newIngredientAmount)
    }
  }
}

// MARK: Configuring views and models

extension DFIngredientsCollectionViewCell {
  
  func configureCellWithModel(_ ingredient: DFIngredientCellViewModel) {
    ingredientViewModel = ingredient
    
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
    cellMainLabel.text = self.ingredientViewModel.ingredientName
  }
  
  private func configureSupportedUnitsRow() {
    supportedUnitsRow.configureSupportedMeasurementUnits(self.ingredientViewModel.measurementUnitViewModels())
  }
  
  private func configureAmountTextFieldProperties() {
    let amountValue = self.ingredientViewModel.getIngredientAmount().measurementValue
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
  
  private func setAmountTextFieldConstraints() {
    amountTextField.removeConstraints(amountTextField.constraints)
    let textFieldSize = amountTextField.sizeThatFits(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
    
    amountTextField.translatesAutoresizingMaskIntoConstraints = false
    let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: amountTextField, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    let topSpacing = NSLayoutConstraint(item: amountTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: supportedUnitsRow, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    let width = NSLayoutConstraint(item: amountTextField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: self.bounds.size.width - self.layoutMargins.left - self.layoutMargins.right)
    let height = NSLayoutConstraint(item: amountTextField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: textFieldSize.height)
    NSLayoutConstraint.activate([centering, topSpacing, height, width])
  }
  
  private func setRemoveIngredientButtonConstraints() {
    removeIngredientButton.removeConstraints(removeIngredientButton.constraints)
    let buttonSize = removeIngredientButton.sizeThatFits(self.bounds.size)
    
    removeIngredientButton.translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: removeIngredientButton, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))  // center horizontally with cell
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: amountTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20))  // 20 pts below amount text field row
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.width))  // set width
    constraints.append(NSLayoutConstraint(item: removeIngredientButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.height)) // set height
    NSLayoutConstraint.activate(constraints)
  }
}
