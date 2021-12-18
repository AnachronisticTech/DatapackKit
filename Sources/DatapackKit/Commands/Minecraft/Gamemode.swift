extension Minecraft {
    public struct Gamemode: Command {
        let entity: EntitySelector?
        let gamemode: GamemodeType

        public init(
            _ gamemode: GamemodeType,
            _ entity: EntitySelector? = nil
        ) {
            if let entity = entity {
                guard entity.playerType else {
                    fatalError("[ERROR] Gamemode command may only be used with player entity selectors.")
                }
            }
            self.entity = entity
            self.gamemode = gamemode
        }

        public var description: String {
            var command = "gamemode \(gamemode)"
            if let entity = entity {
                command += " \(entity)"
            }
            return command
        }

        public var availability: Int { 4 }
    }
}
