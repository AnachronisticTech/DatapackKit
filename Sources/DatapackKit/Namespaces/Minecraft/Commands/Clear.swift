extension Minecraft.Commands {
    public struct Clear: Command {
        let players: [EntitySelector]
        let item: String?
        let count: Int?

        public init(
            _ players: EntitySelector...,
            item: String? = nil,
            count: Int? = nil
        ) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Clear command may only be used with player entity selectors.")
            }
            self.players = players
            self.item = item
            self.count = count
        }

        public var description: String {
            var command = "clear"
            if !players.isEmpty {
                command += " \(players.map({ "\($0)" }).joined(separator: " "))"
            }
            if let item = item {
                command += " \(item)"
            }
            if let count = count {
                command += " \(count)"
            }
            return command
        }

        public var availability: Int { 4 }
    }
}
