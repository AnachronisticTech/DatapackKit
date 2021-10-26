extension Minecraft {
    public struct Gamemode: Command {
        let entity: EntitySelector
        let gamemode: GamemodeType

        public init(
            _ gamemode: GamemodeType,
            _ entity: EntitySelector = .executor
        ) {
            self.entity = entity
            self.gamemode = gamemode
        }
        
        public var description: String {"gamemode \(gamemode) \(entity)"}

        public var availability: Int { 4 }
    }
}
