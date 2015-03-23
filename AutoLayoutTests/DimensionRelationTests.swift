import UIKit
import XCTest

class DimensionRelationTests: XCTestCase {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()

    // MARK: == Tests

    func testSingleViewOnLHS() {
        let constraints = view1[.Width] == view2[.Width]
        XCTAssertEqual([NSLayoutConstraint(view1, .Width, .Equal, view2, .Width, 1, 0)], constraints)
    }

    func testMultipleViewsOnLHS() {
        let constraints = Views(view1,view2)[.Width] == view3[.Width]
        XCTAssertEqual([
            NSLayoutConstraint(view1, .Width, .Equal, view3, .Width, 1, 0),
            NSLayoutConstraint(view2, .Width, .Equal, view3, .Width, 1, 0)], constraints)
    }

    func testEqualConstant() {
        let constraints = view1[.Width] == 10
        XCTAssertEqual([
            NSLayoutConstraint(view1, .Width, .Equal, nil, .NotAnAttribute, 1, 10)], constraints)
    }

    // MARK: >= Tests

    func testGreaterThanOrEqualTo() {
        let constraints = view1[.Width] >= view2[.Width]
        XCTAssertEqual([NSLayoutConstraint(view1, .Width, .GreaterThanOrEqual, view2, .Width, 1, 0)], constraints)
    }

    // MARK: <= Tests

    func testLessThanOrEqualTo() {
        let constraints = view1[.Width] <= view2[.Width]
        XCTAssertEqual([NSLayoutConstraint(view1, .Width, .LessThanOrEqual, view2, .Width, 1, 0)], constraints)
    }

    // MARK: UIView subscript Tests

    func testLayoutWithWidth() {
        let constraintBuilder = view1[.Width]
        XCTAssertEqual(DimensionAttribute.Width, constraintBuilder.attribute)
        XCTAssertEqual([view1], constraintBuilder.views)
    }

    func testLayoutWithHeight() {
        let constraintBuilder = view1[.Height]
        XCTAssertEqual(DimensionAttribute.Height, constraintBuilder.attribute)
        XCTAssertEqual([view1], constraintBuilder.views)
    }

    // MARK: Array Layout Tests

    func testLayoutWithMultipleViewsWidth() {
        let constraintBuilder = Views(view1, view2)[.Width]
        XCTAssertEqual(DimensionAttribute.Width, constraintBuilder.attribute)
        XCTAssertEqual([view1, view2], constraintBuilder.views)
    }

    // MARK: Multiplier Tests

    func testMultiplierMultiplication() {
        let constraintBuilder = view1[.Width] * 0.5
        XCTAssertEqual(CGFloat(0.5), constraintBuilder.multiplier)
    }

    func testSuccessiveMultiplierMultiplication() {
        let constraintBuilder = view1[.Width] * 0.5 * 0.25
        XCTAssertEqual(CGFloat(0.125), constraintBuilder.multiplier)
    }

    func testMultiplierDivision() {
        let constraintBuilder = view1[.Width] / 2
        XCTAssertEqual(CGFloat(0.5), constraintBuilder.multiplier)
    }

    func testSuccessiveMultiplierDivision() {
        let constraintBuilder = view1[.Width] / 2 / 2.5
        XCTAssertEqual(CGFloat(0.2), constraintBuilder.multiplier)
    }

    // MARK: Constant Tests

    func testConstantAddition() {
        let constraintBuilder = view1[.Width] + 10
        XCTAssertEqual(CGFloat(10), constraintBuilder.constant)
    }

    func testSuccessiveConstantAddition() {
        let constraintBuilder = view1[.Width] + 10 + 5
        XCTAssertEqual(CGFloat(15), constraintBuilder.constant)
    }

    func testConstantSubtraction() {
        let constraintBuilder = view1[.Width] - 10
        XCTAssertEqual(CGFloat(-10), constraintBuilder.constant)
    }

    func testSuccessiveConstantSubtraction() {
        let constraintBuilder = view1[.Width] - 10 - 5
        XCTAssertEqual(CGFloat(-15), constraintBuilder.constant)
    }
}