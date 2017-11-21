//
//  DFRecipeTests.swift
//  DogFoodCalculatorTests
//
//  Created by Roshan Goli on 11/10/17.
//  Copyright © 2017 Roshan Goli. All rights reserved.
//

import XCTest
@testable import DogFoodCalculator

class DFRecipeTests: XCTestCase {
  private var testRecipe: DFRecipe = DFRecipe()
  private var wasNotificationObserved: Bool = false
  private var notificationTestingBlock: ((DFRecipeUpdateModel) -> Void)?
  
  func testUpdateIngredient() {
    let initialIngredient = DFIngredientModel(ingredientName: "Test",
                                              supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp],
                                              nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)),
                                              defaultMeasurementUnit: DFMeasurementUnit.tsp,
                                              isSelected: false,
                                              amount: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 4.0))
    self.testRecipe.addIngredient(initialIngredient)
    
    let newAmount = DFIngredientModelBuilder(fromModel: initialIngredient)
      .withIngredientMeasurement(DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 3.0))
      .build()
    self.testRecipe.updateIngredient(oldIngredient: initialIngredient, withNewIngredient: newAmount)
    XCTAssertFalse(self.testRecipe.ingredients.contains(initialIngredient))
    XCTAssertTrue(self.testRecipe.ingredients.contains(newAmount))
  }
  
  func testAddIngredient() {
    XCTAssertTrue(self.testRecipe.ingredients.count == 0)
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.ingredients.count == 1)
  }
  
  func testRemoveIngredient() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    
    let ingredientToRemove = DFRecipeTests.testIngredient()
    self.testRecipe.addIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.ingredients.count == 2)
    XCTAssertTrue(self.testRecipe.ingredients.contains(ingredientToRemove))
    
    self.testRecipe.removeIngredient(ingredientToRemove)
    XCTAssertTrue(self.testRecipe.ingredients.count == 1)
    XCTAssertFalse(self.testRecipe.ingredients.contains(ingredientToRemove))
  }
  
  func testRemoveAllIngredients() {
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    self.testRecipe.addIngredient(DFRecipeTests.testIngredient())
    XCTAssertTrue(self.testRecipe.ingredients.count == 2)
    
    self.testRecipe.removeAllIngredients()
    XCTAssertTrue(self.testRecipe.ingredients.count == 0)
  }
  
  func testNotificationPosting() {
    self.testRecipe.addRecipeUpdateObserver(self)
    
    // Testing adding recipe ingredient notification
    let initialIngredient = DFIngredientModel(ingredientName: "Test",
                                              supportedMeasurementUnits: [DFMeasurementUnit.tsp, DFMeasurementUnit.tbsp],
                                              nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)),
                                              defaultMeasurementUnit: DFMeasurementUnit.tsp,
                                              isSelected: false,
                                              amount: DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 4.0))
    self.notificationTestingBlock = self.notifTestingBlockForUpdateType(DFRecipeUpdateType.add)
    self.testRecipe.addIngredient(initialIngredient)
    XCTAssertTrue(self.wasNotificationObserved, "Notification was not observed")
    self.wasNotificationObserved = false
    
    // Testing updating recipe ingredient notification
    let newAmount = DFIngredientModelBuilder(fromModel: initialIngredient)
      .withIngredientMeasurement(DFMeasurement(measurementUnit: DFMeasurementUnit.tsp, measurementValue: 3.0))
      .build()
    self.notificationTestingBlock = self.notifTestingBlockForUpdateType(DFRecipeUpdateType.update)
    self.testRecipe.updateIngredient(oldIngredient: initialIngredient, withNewIngredient: newAmount)
    XCTAssertTrue(self.wasNotificationObserved, "Notification was not observed")
    self.wasNotificationObserved = false
    
    // Testing removing recipe ingredient notification
    self.notificationTestingBlock = self.notifTestingBlockForUpdateType(DFRecipeUpdateType.remove)
    self.testRecipe.removeIngredient(newAmount)
    XCTAssertTrue(self.wasNotificationObserved, "Notification was not observed")
  }
  
  private class func testIngredient() -> DFIngredientModel {
    return DFIngredientModel(ingredientName: "Test: \(arc4random_uniform(100))",
      supportedMeasurementUnits: [DFMeasurementUnit.cup, DFMeasurementUnit.tsp],
      nutritionalInfo: DFNutritionalInfo(servingSize: DFMeasurement(measurementUnit: DFMeasurementUnit.lb, measurementValue: 1.0)))
  }
  
  private func notifTestingBlockForUpdateType(_ updateType: DFRecipeUpdateType) -> ((DFRecipeUpdateModel) -> Void) {
    return {
      (updateModel: DFRecipeUpdateModel) -> Void in
      XCTAssert(updateModel.updateType == updateType)
    }
  }
  
  override func tearDown() {
    self.testRecipe.removeObserver(self)
  }
}

extension DFRecipeTests : DFRecipeUpdateListener {
  func observeRecipeUpdate(notification: NSNotification) {
    self.wasNotificationObserved = true
    guard let updateModel = notification.userInfo?[DFRecipe.notificationUpdateKey] as! DFRecipeUpdateModel! else {
      XCTFail("Update model not received in notification")
      return
    }
    
    guard let notifBlock = self.notificationTestingBlock else {
      XCTFail("Notif block not set")
      return
    }
    
    notifBlock(updateModel)
    self.notificationTestingBlock = nil
  }
  
  
}
