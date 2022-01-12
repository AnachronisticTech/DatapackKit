extension Minecraft.Commands.Scoreboard {
    public struct Players: Command {
        let variant: Variant

        init(variant: Variant) {
            self.variant = variant
        }

        public init(list player: EntitySelector? = nil) {
            if let player = player {
                guard player.playerType else {
                    fatalError("[ERROR] Scoreboard player list command may only be used with player entity selectors.")
                }
            }
            self.init(variant: .list(player))
        }

        public init(
            getScoreFor player: EntitySelector,
            in objective: String
        ) {
            guard player.playerType else {
                fatalError("[ERROR] Scoreboard player get command may only be used with player entity selectors.")
            }
            self.init(variant: .get(player, objective))
        }

        public init(
            setScore value: Int,
            for player: EntitySelector,
            in objective: String
        ) {
            guard player.playerType else {
                fatalError("[ERROR] Scoreboard player set command may only be used with player entity selectors.")
            }
            self.init(variant: .set(player, objective, value))
        }

        public init(
            addToScore value: Int,
            for player: EntitySelector,
            in objective: String
        ) {
            guard player.playerType else {
                fatalError("[ERROR] Scoreboard player add command may only be used with player entity selectors.")
            }
            self.init(variant: .add(player, objective, value))
        }

        public init(
            subtractFromScore value: Int,
            for player: EntitySelector,
            in objective: String
        ) {
            guard player.playerType else {
                fatalError("[ERROR] Scoreboard player subtract command may only be used with player entity selectors.")
            }
            self.init(variant: .remove(player, objective, value))
        }

        public init(
            resetScoresFor players: EntitySelector...,
            in objectives: String...
        ) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Scoreboard player reset command may only be used with player entity selectors.")
            }
            self.init(variant: .reset(players, objectives))
        }

        public init(
            enableTriggerFor players: EntitySelector...,
            in objective: String
        ) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Scoreboard player enable command may only be used with player entity selectors.")
            }
            self.init(variant: .enable(players, objective))
        }

        public init(
            perform operation: Operation,
            on targets: EntitySelector...,
            in targetObjective: String,
            using sources: EntitySelector...,
            from sourceObjective: String
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Scoreboard player operation command may only be used with player entity selectors as targets.")
            }
            guard !sources.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Scoreboard player operation command may only be used with player entity selectors as sources.")
            }
            self.init(variant: .operation(targets, targetObjective, operation, sources, sourceObjective))
        }

        public var description: String {
            var command = "scoreboard players "
            switch variant {
                case let .list(player):
                    command += "list"
                    if let player = player {
                        command += " \(player)"
                    }
                case let .get(player, objective):
                    command += "get \(player) \(objective)"
                case let .set(player, objective, value):
                    command += "set \(player) \(objective) \(value)"
                case let .add(player, objective, value):
                    command += "add \(player) \(objective) \(value)"
                case let .remove(player, objective, value):
                    command += "remove \(player) \(objective) \(value)"
                case let .reset(players, objectives):
                    command += "reset \(players.isEmpty ? "*" : players.targetsToString())"
                    if objectives.count > 0 {
                        command += " \(objectives[0])"
                    }
                    if objectives.count > 1 {
                        for index in 1..<objectives.count {
                            command += "\nscoreboard players reset \(players) \(objectives[index])"
                            }
                    }
                case let .enable(players, objective):
                    command += "enable \(players.isEmpty ? "*" : players.targetsToString()) \(objective)"
                case let .operation(targets, targetObjective, operation, sources, sourceObjective):
                    command += "operation \(targets.targetsToString()) \(targetObjective) \(operation) \(sources.targetsToString()) \(sourceObjective)"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case list(EntitySelector? = nil)
            case get(EntitySelector, String)
            case set(EntitySelector, String, Int)
            case add(EntitySelector, String, Int)
            case remove(EntitySelector, String, Int)
            case reset([EntitySelector], [String])
            case enable([EntitySelector], String)
            case operation([EntitySelector], String, Operation, [EntitySelector], String)
        }

        public enum Operation: String {
            case addition = "+="
            case subtraction = "-="
            case multiplication = "*="
            case integerDivision = "/="
            case modulus = "%="
            case assignment = "="
            case minimum = "<"
            case maximum = ">"
            case swap = "><"
        }
    }
}
