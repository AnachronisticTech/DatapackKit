extension Minecraft {
    public struct Ban: Command {
        let players: [EntitySelector]
        let reason: String?

        public init(
            _ players: EntitySelector...,
            reason: String? = nil
        ) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Ban command may only be used with player entity selectors.")
            }
            guard !players.isEmpty else {
                fatalError("[ERROR] Ban command may not be used without providing at least one player entity selector.")
            }
            self.players = players
            self.reason = reason
        }

        public var description: String {
            var command = "ban \(players.map({ "\($0)" }).joined(separator: " "))"
            if let reason = reason {
                command += " \(reason)"
            }
            return command
        }

        public var availability: Int { 4 }
    }
}
