/// After a target selector, optional arguments can be used to narrow down the set of targets to a group that also matches certain criteria. When used with `@a` or `@e`, arguments narrow down the targets from the full list to a specific group. When used with `@p` or `@r`, the nearest or random player is selected from the group. When used with `@s`, the player using the command is targeted only if they would be in the narrowed group.
public enum EntitySelectorArgument: CustomStringConvertible {
    // Selection by position
    /// Selection by coordinate
    case x(Double), y(Double), z(Double)
    /// Selection by distance
    case distance(Double), distanceRange(ClosedRange<Double>)
    /// Selection by volume
    case dx(Double), dy(Double), dz(Double)

    // Selection by traits
    case limit(Int)
    case sortNearest, sortFurthest, sortRandom, sortArbitrary
    /// Selection by level
    case level(Int), levelRange(ClosedRange<Int>)
    /// Selection by gamemode
    case gamemode(GamemodeType, exclude: Bool = false)
    /// Selection by name
    case name(String, exclude: Bool = false)
    /// Selection by xRotation
    case xRotation(Double), xRotationRange(ClosedRange<Double>)
    /// Selection by yRotation
    case yRotation(Double), yRotationRange(ClosedRange<Double>)

    case raw(String)

    public var description: String {
        switch self {
            case let .x(value): return "x=\(value)"
            case let .y(value): return "y=\(value)"
            case let .z(value): return "z=\(value)"
            case let .distance(value): return "distance=\(value)"
            case let .distanceRange(value): return "distance=\(value)".replacingOccurrences(of: "...", with: "..")
            case let .dx(value): return "dx=\(value)"
            case let .dy(value): return "dy=\(value)"
            case let .dz(value): return "dz=\(value)"
            case let .limit(value): return "limit=\(value)"
            case .sortNearest: return "sort=nearest"
            case .sortFurthest: return "sort=farthest"
            case .sortRandom: return "sort=random"
            case .sortArbitrary: return "sort=arbitrary"
            case let .level(value): return "level=\(value)"
            case let .levelRange(value): return "level=\(value)".replacingOccurrences(of: "...", with: "..")
            case let .gamemode(value, inverted): return "gamemode=\(inverted ? "!" : "")\(value)"
            case let .name(value, inverted): return "name=\(inverted ? "!" : "")\(value)"
            case let .xRotation(value): return "x_rotation=\(value)"
            case let .xRotationRange(value): return "x_rotation=\(value)".replacingOccurrences(of: "...", with: "..")
            case let .yRotation(value): return "y_rotation=\(value)"
            case let .yRotationRange(value): return "y_rotation=\(value)".replacingOccurrences(of: "...", with: "..")
            case let .raw(value): return value
        }
    }
}
