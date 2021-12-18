extension Minecraft {
    public struct Team: Command {
        let variant: Variant

        public init(team: String? = nil) {
            variant = .list(team)
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

        public init(modify team: String, _ options: TeamOption...) {
            variant = .modify(team, options)
        }

        public var description: String {
            var command = "team "
            switch variant {
                case let .list(team):
                    command += "list"
                    if let team = team {
                        command += " \(team)"
                    }
                case let .add(team, displayName):
                    command += "add \(team)"
                    if let displayName = displayName {
                        command += " \(displayName)"
                    }
                case let .remove(team):
                    command += "remove \(team)"
                case let .empty(team):
                    command += "empty \(team)"
                case let .join(team, players):
                    command += "join \(team)"
                    if let players = players {
                        command += " \(players.map({ "\($0)" }).joined(separator: " "))"
                    }
                case let .leave(players):
                    command += "leave \(players.map({ "\($0)" }).joined(separator: " "))"
                case let .modify(team, options):
                    var commands = [String]()
                    for option in options {
                        commands.append("team modify \(team) \(option)")
                    }
                    return commands.joined(separator: "\n")
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case list(String? = nil)
            case add(String, String? = nil)
            case remove(String)
            case empty(String)
            case join(String, [EntitySelector]? = nil)
            case leave([EntitySelector])
            case modify(String, [TeamOption])
        }
    }
}
