import struct Foundation.UUID

public enum EntitySelector: CustomStringConvertible {
    /// Targets the nearest player from the command's execution. If there are multiple nearest players, caused by them being precisely the same distance away, the player who most recently joined the server is selected.
    case nearestPlayer

    /// Targets a random player.
    case randomPlayer

    /// Targets every player, alive or not.
    case allPlayers

    /// Targets all alive entities (including players) in loaded chunks.
    case allEntites

    /// Targets the entity (alive or not) that executed the command. It does not target anything if the command was run by a command block or server console.
    case executor

    /// Targets the named player.
    case namedPlayer(String)

    /// Targets the entity with the UUID.
    case uuid(UUID)

    public var description: String {
        switch self {
            case .nearestPlayer: return "@p"
            case .randomPlayer: return "@r"
            case .allPlayers: return "@a"
            case .allEntites: return "@e"
            case .executor: return "@s"
            case .namedPlayer(let name): return name
            case .uuid(let uuid): return uuid.uuidString
        }
    }
}
