extension Minecraft.Commands {
    public struct Experience: Command {
        let variant: Variant

        public init(addPoints points: Int, to players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Add experience command may only be used with player entity selectors.")
            }
            variant = .addPoints(points, players)
        }

        public init(addLevels points: Int, to players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Add experience command may only be used with player entity selectors.")
            }
            variant = .addLevels(points, players)
        }

        public init(setPoints points: Int, to players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Set experience command may only be used with player entity selectors.")
            }
            variant = .setPoints(points, players)
        }

        public init(setLevels points: Int, to players: EntitySelector...) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Set experience command may only be used with player entity selectors.")
            }
            variant = .setLevels(points, players)
        }

        public init(queryPointsOf players: EntitySelector...) {
            guard !players.map({ $0.singlePlayerType }).contains(false) else {
                fatalError("[ERROR] Query experience command may only be used with single-player entity selectors.")
            }
            variant = .queryPoints(players)
        }

        public init(queryLevelsOf  players: EntitySelector...) {
            guard !players.map({ $0.singlePlayerType }).contains(false) else {
                fatalError("[ERROR] Add experience command may only be used with single-player entity selectors.")
            }
            variant = .queryLevels(players)
        }

        public var description: String {
            var command = "experience "
            switch variant {
                case let .addPoints(amount, players):
                    command += "add \(players.targetsToString()) \(amount) points"
                case let .addLevels(amount, players):
                    command += "add \(players.targetsToString()) \(amount) levels"
                case let .setPoints(amount, players):
                    command += "set \(players.targetsToString()) \(amount) points"
                case let .setLevels(amount, players):
                    command += "set \(players.targetsToString()) \(amount) levels"
                case let .queryPoints(players):
                    command += "query \(players.targetsToString()) points"
                case let .queryLevels(players):
                    command += "query \(players.targetsToString()) levels"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case addPoints(Int, [EntitySelector])
            case addLevels(Int, [EntitySelector])
            case setPoints(Int, [EntitySelector])
            case setLevels(Int, [EntitySelector])
            case queryPoints([EntitySelector])
            case queryLevels([EntitySelector])
        }
    }
}
