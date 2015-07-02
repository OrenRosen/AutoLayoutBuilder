import UIKit

public class VerticalRelation: AbstractSingleRelation, SingleRelation {

    typealias AttributeType = VerticalAttribute
    let attribute: VerticalAttribute
    public var trueAttribute: NSLayoutAttribute { return verticalPositionToLayoutAttribute(self.attribute)}

    init(attribute: VerticalAttribute, views: [UIView]) {
        self.attribute = attribute
        super.init(views: views)
    }
}

// MARK: Operators

public func ==(lhs: VerticalRelation, rhs: LayoutGuideRelation) -> [NSLayoutConstraint] {
    return makeVerticalPositionRelationConstraints(lhs, rhs, .Equal)
}

public func >=(lhs: VerticalRelation, rhs: LayoutGuideRelation) -> [NSLayoutConstraint] {
    return makeVerticalPositionRelationConstraints(lhs, rhs, .GreaterThanOrEqual)
}

public func <=(lhs: VerticalRelation, rhs: LayoutGuideRelation) -> [NSLayoutConstraint] {
    return makeVerticalPositionRelationConstraints(lhs, rhs, .LessThanOrEqual)
}

// MARK: Attribute conversion

internal func verticalPositionToLayoutAttribute(attribute: VerticalAttribute) -> NSLayoutAttribute {
    switch attribute {
    case .CenterY: return .CenterY
    case .Top: return .Top
    case .Bottom: return .Bottom
    case .Baseline: return .Baseline
    case .FirstBaseline: return .FirstBaseline
    case .CenterYWithinMargins: return .CenterYWithinMargins
    case .TopMargin: return .TopMargin
    case .BottomMargin: return .BottomMargin
    }
}

// MARK: Internal

func makeVerticalPositionRelationConstraints(lhs: VerticalRelation, rhs: LayoutGuideRelation, relation: NSLayoutRelation) -> [NSLayoutConstraint] {
    return lhs.views.map { NSLayoutConstraint($0, lhs.trueAttribute, relation, rhs.layoutGuide, rhs.trueAttribute, 1, rhs.constant) }
}