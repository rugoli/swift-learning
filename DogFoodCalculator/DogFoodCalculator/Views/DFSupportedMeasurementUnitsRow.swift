//
//  DFSupportedMeasurementUnitsRow.swift
//  DogFoodCalculator
//
//  Created by Roshan on 11/2/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import UIKit

class DFSupportedMeasurementUnitsRow: UIView {
    var supportedMeasurementUnits: [UIButton]

    init() {
        self.supportedMeasurementUnits = [UIButton]()
        
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
    
    func configureSupportedMeasurementUnits(_ supportedUnits: [DFMeasurementUnit]) {
        self.resetAllButtons()
        
        for unit: DFMeasurementUnit in supportedUnits {
            let button: UIButton = self.buttonForMeasurementUnit(unit)
            self.supportedMeasurementUnits.append(button)
            self.addSubview(button)
        }
    }
    
    private func buttonForMeasurementUnit(_ unit: DFMeasurementUnit) -> UIButton {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle(unit.rawValue, for: UIControlState.normal)
        button.setTitle(unit.rawValue, for: UIControlState.selected)
        button.isHidden = false
        button.backgroundColor = UIColor.white
        
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
    
    private func addButtonConstraints(button: UIButton, prevButton: UIButton?) {
        let cellSize = self.bounds.size
        let buttonSize = button.sizeThatFits(cellSize)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: button, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.width))
        constraints.append(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: buttonSize.height))
        if (prevButton != nil) {
            constraints.append(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 10))
            constraints.append(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        }
        NSLayoutConstraint.activate(constraints)
    }

}
