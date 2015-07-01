import UIKit

public class DimensionRelation: AbstractSingleRelation, SingleRelation {

    typealias AttributeType = DimensionAttribute
    let attribute: DimensionAttribute
    public var trueAttribute: NSLayoutAttribute {
        switch attribute {
        case .Width: return .Width
        case .Height: return .Height
        }
    }

    init(attribute: DimensionAttribute, views: [UIView]) {
        self.attribute = attribute
        super.init(views: views)
    }
}

// MARK: Operators

public func ==(lhs: DimensionRelation, rhs: CGFloat) -> [NSLayoutConstraint] { return makeDimensionRelationConstraints(lhs, rhs, .Equal) }

public func >=(lhs: DimensionRelation, rhs: CGFloat) -> [NSLayoutConstraint] { return makeDimensionRelationConstraints(lhs, rhs, .GreaterThanOrEqual) }

public func <=(lhs: DimensionRelation, rhs: CGFloat) -> [NSLayoutConstraint] { return makeDimensionRelationConstraints(lhs, rhs, .LessThanOrEqual) }

// MARK: Internal Helper Functions

internal func makeDimensionRelationConstraints(lhs: DimensionRelation, rhs: CGFloat, relation: NSLayoutRelation) -> [NSLayoutConstraint] {
    return lhs.views.map() { NSLayoutConstraint($0, lhs.trueAttribute, relation, nil, .NotAnAttribute, 1, rhs) }
}