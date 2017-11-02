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
    private var ingredientModel: DFIngredientModel!
    
    static let reuseIdentifier: String = "calculator-cell"
    
    override init(frame: CGRect) {
        cellMainLabel = UILabel()
        supportedUnitsRow = DFSupportedMeasurementUnitsRow()
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        self.addSubview(cellMainLabel)
        self.addSubview(supportedUnitsRow)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setMainLabelConstraints()
        self.setSupportedUnitsRowConstraints()
    }
    
    private func setMainLabelConstraints() {
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
        let cellSize = self.bounds.size
        let cellMargins = self.layoutMargins
        let rowSize: CGSize = CGSize(width: cellSize.width - cellMargins.left - cellMargins.right, height: 40)
        
        supportedUnitsRow.translatesAutoresizingMaskIntoConstraints = false
        let centering = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: supportedUnitsRow, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        let topSpacing = NSLayoutConstraint(item: supportedUnitsRow, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cellMainLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
        let height = NSLayoutConstraint(item: supportedUnitsRow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: rowSize.height)
        NSLayoutConstraint.activate([centering, topSpacing, height])
    }
}

// MARK:

// Configuring views and models

extension DFCalculatorCollectionViewCell {
    
    func configureCellWithModel(_ ingredient: DFIngredientModel) {
        ingredientModel = ingredient
        self.configureMainLabelProperties()
        self.configureSupportedUnitsRow()
        self.setNeedsLayout()
    }
    
    private func configureMainLabelProperties() {
        cellMainLabel.text = ingredientModel.ingredientName
        cellMainLabel.textColor = UIColor.blue
        cellMainLabel.numberOfLines = 0
        cellMainLabel.textAlignment = NSTextAlignment.center
        cellMainLabel.font = cellMainLabel.font.withSize(18)
    }
    
    private func configureSupportedUnitsRow() {
        supportedUnitsRow.configureSupportedMeasurementUnits(ingredientModel.supportedMeasurementUnits)
    }
}
