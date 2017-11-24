//
//  DFMeasurementUnitButtonView.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/22/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

protocol DFMeasurementUnitButtonDelegate : class {
  func willSetHighlightValue(isHighlighted: Bool)
  func willSetSelectedValue(isSelected: Bool)
}

class DFMeasurementUnitButtonView: UIView {
  private var button: DFMeasurementUnitButton
  private let buttonAction: (UIButton, DFMeasurementUnit) -> Void
  private var viewModel: DFMeasurementUnitViewModel?
  
  init(targetAction: @escaping (UIButton, DFMeasurementUnit) -> Void) {
    button = DFMeasurementUnitButton(frame: .zero)
    self.buttonAction = targetAction
    
    button.setTitleColor(DFColorPalette.colorForType(.textColor), for: .normal)
    button.setTitleColor(.white, for: .selected)
    button.setTitleColor(.black, for: .highlighted)
    
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
    
    button.isHidden = false
    button.isSelected = false

    super.init(frame: .zero)
    
    self.backgroundColor = .white
    self.layer.cornerRadius = 5
    self.layer.borderWidth = 1
    self.layer.borderColor = DFColorPalette.colorForType(.borderColor).cgColor
    
    button.addTarget(self, action: #selector(self.tappedMeasurementButton(sender:)), for: UIControlEvents.touchUpInside)
    button.delegate = self
    
    self.addSubview(button)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func tappedMeasurementButton(sender: UIButton) {
    buttonAction(sender, self.viewModel!.measurementUnit)
  }
  
  private func setAutolayoutConstraints() {
    self.removeConstraints(self.constraints)
    self.button.removeConstraints(self.button.constraints)
    let buttonSize = self.button.sizeThatFits(CGSize(width: 100, height: 100))
    
    self.button.translatesAutoresizingMaskIntoConstraints = false
    self.translatesAutoresizingMaskIntoConstraints = false

    self.button.constrainEdges(toView: self)
    let width = self.button.widthConstraint(forWidth: buttonSize.width)
    let height = self.button.heightConstraint(forHeight: buttonSize.height)

    NSLayoutConstraint.activate([width, height])
  }
  
  func configureWithViewModel(viewModel: DFMeasurementUnitViewModel) {
    self.viewModel = viewModel
    
    button.setTitle(self.viewModel!.measurementUnit.rawValue, for: .normal)
    button.setTitle(self.viewModel!.measurementUnit.rawValue, for: .highlighted)
    button.setTitle(self.viewModel!.measurementUnit.rawValue, for: .selected)
    
    button.isSelected = viewModel.isSelected
    
    self.setAutolayoutConstraints()
  }
  
}

// MARK: Button delegate

extension DFMeasurementUnitButtonView : DFMeasurementUnitButtonDelegate {
  func willSetSelectedValue(isSelected: Bool) {
    self.backgroundColor = isSelected ? DFColorPalette.colorForType(.measurementUnitSelected) : UIColor.white
  }
  
  func willSetHighlightValue(isHighlighted: Bool) {
    self.backgroundColor = isHighlighted ? DFColorPalette.colorForType(.measurementUnitHighlighted) : UIColor.white
  }
}

// MARK: UIButton subclass

class DFMeasurementUnitButton : UIButton {
  weak var delegate: DFMeasurementUnitButtonDelegate?
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isHighlighted: Bool {
    willSet {
      self.delegate?.willSetHighlightValue(isHighlighted: newValue)
    }
  }
  
  override var isSelected: Bool {
    willSet {
      self.delegate?.willSetSelectedValue(isSelected: newValue)
    }
    
  }
}

