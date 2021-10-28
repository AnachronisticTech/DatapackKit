extension Minecraft {
    public struct Team: Command {
        let variant: TeamVariant

        public init(teams: [String]? = nil) {
            variant = .list(teams)
        }

        public init(add team: String, displayName: String? = nil) {
            guard team.count <= 16 else {
                fatalError("[ERROR] Add team command may only be used with team names less than 16 characters long.")
            }
            variant = .add(team, displayName)
        }

        public init(remove team: String) {
            variant = .remove(team)
        }

        public init(empty team: String) {
            variant = .empty(team)
        }

        public init(join team: String) {
            variant = .join(team)
        }

        public init(join team: String, players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Join team command may only be used with player entity selectors.")
            }
            variant = .join(team, players)
        }

        public init(leave players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Leave team command may only be used with player entity selectors.")
            }
            variant = .leave(players)
        }

        public init(modify team: String, _ options: [TeamOption]) {
            variant = .modify(team, options)
        }

        public var description: String {
            switch variant {
                case let .list(teams):
                    if let teams = teams {
                        return "team list \(teams)"
                    } else {
                        return "team list"
                    }
                case let .add(team, displayName):
                    if let displayName = displayName {
                        return "team add \(team) \(displayName)"
                    } else {
                        return "team add \(team)"
                    }
                case let .remove(team): return "team remove \(team)"
                case let .empty(team): return "team empty \(team)"
                case let .join(team, players):
                    if let players = players {
                        return "team join \(team) \(players.map({ "\($0)" }).joined(separator: " "))"
                    } else {
                        return "team join \(team)"
                    }
                case let .leave(players): return "team leave \(players.map({ "\($0)" }).joined(separator: " "))"
                case let .modify(team, options):
                    var commands = [String]()
                    for option in options {
                        commands.append("team modify \(team) \(option)")
                    }
                    return commands.joined(separator: "\n")
            }
        }

        public var availability: Int {
            switch variant {
                default: return 4
            }
        }

        enum TeamVariant {
            case list([String]? = nil)
            case add(String, String? = nil)
            case remove(String)
            case empty(String)
            case join(String, [EntitySelector]? = nil)
            case leave([EntitySelector])
            case modify(String, [TeamOption])
        }
    }
}