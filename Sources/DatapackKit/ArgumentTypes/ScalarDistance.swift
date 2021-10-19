public enum ScalarDistance: CustomStringConvertible {
    case absolute(Int)
    case relative(_ distance: Int = 0)
    case local(_ distance: Int = 0)

    public var description: String {
        switch self {
            case .absolute(let distance): return "\(distance)"
            case .relative(let distance): return "~\(distance != 0 ? "\(distance)" : "")"
            case .local(let distance): return "^\(distance != 0 ? "\(distance)" : "")"
        }
    }
}

extension ScalarDistance: Equatable {
    public static func ==(lhs: ScalarDistance, rhs: ScalarDistance) -> Bool {
        switch (lhs, rhs) {
            case (.absolute(let l), .absolute(let r)): return l == r
            case (.relative(let l), .relative(let r)): return l == r
            case (.local(let l), .local(let r)): return l == r
            default: return false
        }
    }
}
