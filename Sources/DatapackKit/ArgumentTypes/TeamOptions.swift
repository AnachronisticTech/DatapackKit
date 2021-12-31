public enum TeamOption: CustomStringConvertible {
    case displayName(String)
    case color(Color)
    case resetColor
    case friendlyFire(Bool = true)
    case seeFriendlyInvisibles(Bool = true)
    case nametagVisibility(VisibilityRule = .always)
    case deathMessageVisibility(VisibilityRule = .always)
    case collisionRule(CollisionRule = .always)
    case prefix(String)
    case suffix(String)

    public var description: String {
        switch self {
            case let .displayName(name): return "displayName \(name)"
            case let .color(color): return "color \(color.rawValue.kebabCase())"
            case .resetColor: return "color reset"
            case let .friendlyFire(enabled): return "friendlyFire \(enabled)"
            case let .seeFriendlyInvisibles(enabled): return "seeFriendlyInvisibles \(enabled)"
            case let .nametagVisibility(rule): return "nametagVisibility \(rule.rawValue.kebabCase())"
            case let .deathMessageVisibility(rule): return "deathMessageVisibility \(rule.rawValue.kebabCase())"
            case let .collisionRule(rule): return "collisionRule \(rule.rawValue.kebabCase())"
            case let .prefix(prefix): return "prefix \(prefix)"
            case let .suffix(suffix): return "suffix \(suffix)"
        }
    }
}

public enum VisibilityRule: String {
    case always, never, hideForOtherTeams, hideForOwnTeam
}

public enum CollisionRule: String {
    case always, never, pushOtherTeams, pushOwnTeam
}
