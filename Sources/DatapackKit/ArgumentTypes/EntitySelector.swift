import struct Foundation.UUID

public enum EntitySelector: CustomStringConvertible {
    /// Targets the nearest player from the command's execution. If there are multiple nearest players, caused by them being precisely the same distance away, the player who most recently joined the server is selected.
    case nearestPlayer([EntitySelectorArgument]? = nil)

    /// Targets a random player.
    case randomPlayer([EntitySelectorArgument]? = nil)

    /// Targets every player, alive or not.
    case allPlayers([EntitySelectorArgument]? = nil)

    /// Targets all alive entities (including players) in loaded chunks.
    case allEntites([EntitySelectorArgument]? = nil)

    /// Targets the entity (alive or not) that executed the command. It does not target anything if the command was run by a command block or server console.
    case executor([EntitySelectorArgument]? = nil)

    /// Targets the named player.
    case namedPlayer(String)

    /// Targets the entity with the UUID.
    case uuid(UUID)

    public var description: String {
        switch self {
            case .nearestPlayer(let arguments):
                var target = "@p"
                if let arguments = arguments {
                    target += "[\(arguments.map({ "\($0)" }).joined(separator: ","))]"
                }
                return target
            case .randomPlayer(let arguments):
                var target = "@r"
                if let arguments = arguments {
                    target += "[\(arguments.map({ "\($0)" }).joined(separator: ","))]"
                }
                return target
            case .allPlayers(let arguments):
                var target = "@a"
                if let arguments = arguments {
                    target += "[\(arguments.map({ "\($0)" }).joined(separator: ","))]"
                }
                return target
            case .allEntites(let arguments):
                var target = "@e"
                if let arguments = arguments {
                    target += "[\(arguments.map({ "\($0)" }).joined(separator: ","))]"
                }
                return target
            case .executor(let arguments):
                var target = "@s"
                if let arguments = arguments {
                    target += "[\(arguments.map({ "\($0)" }).joined(separator: ","))]"
                }
                return target
            case .namedPlayer(let name): return name
            case .uuid(let uuid): return uuid.uuidString
        }
    }

    public var playerType: Bool {
        switch self {
            case .allEntites: return false
            default: return true
        }
    }

    public var singlePlayerType: Bool {
        switch self {
            case .allEntites, .allPlayers: return false
            default: return true
        }
    }
}
