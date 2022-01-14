extension Minecraft.Commands {
    public struct Title: Command {
        let players: [EntitySelector]
        let variant: Variant

        init(players: [EntitySelector], _ variant: Variant) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Title command may only be used with player entity selectors.")
            }
            guard !players.isEmpty else {
                fatalError("[ERROR] Title command may not be used without providing at least one player entity selector.")
            }
            self.players = players
            self.variant = variant
        }

        public init(clearFrom players: EntitySelector...) {
            self.init(players: players, .clear)
        }

        public init(resetFor players: EntitySelector...) {
            self.init(players: players, .reset)
        }

        public init(setTitle text: String, for players: EntitySelector...) {
            self.init(players: players, .title(text))
        }

        public init(setSubtitle text: String, for players: EntitySelector...) {
            self.init(players: players, .subtitle(text))
        }

        public init(setActionBarText text: String, for players: EntitySelector...) {
            self.init(players: players, .actionBar(text))
        }

        public init(
            fadeIn: Int,
            stay: Int,
            fadeOut: Int,
            for players: EntitySelector...
        ) {
            self.init(players: players, .times(fadeIn, stay, fadeOut))
        }

        public var description: String {
            var command = "title \(players.targetsToString()) "
            switch variant {
                case .clear:
                    command += "clear"
                case .reset:
                    command += "reset"
                case let .title(text):
                    command += "title \"\(text)\""
                case let .subtitle(text):
                    command += "subtitle \"\(text)\""
                case let .actionBar(text):
                    command += "actionbar \"\(text)\""
                case let .times(fadeIn, stay, fadeOut):
                    command += "times \(fadeIn) \(stay) \(fadeOut)"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case clear
            case reset
            case title(String)
            case subtitle(String)
            case actionBar(String)
            case times(Int, Int, Int)
        }
    }
}
