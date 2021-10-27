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
            self.players = players
            self.reason = reason
        }

        public var description: String {
            if let reason = reason {
                return "ban \(players.map({ "\($0)" }).joined(separator: " ")) \(reason)"
            } else {
                return "ban \(players.map({ "\($0)" }).joined(separator: " "))"
            }
        }

        public var availability: Int { 4 }
    }
}
