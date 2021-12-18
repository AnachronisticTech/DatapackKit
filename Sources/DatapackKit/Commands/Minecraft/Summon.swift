extension Minecraft {
    public struct Summon: Command {
        let entity: String
        let position: Vector3?
        let nbt: String?

        public init(
            _ entity: String,
            position: Vector3? = nil,
            nbt: String? = nil
        ) {
            self.entity = entity
            self.position = position
            self.nbt = nbt
        }

        public var description: String {
            var command = "summon \(entity)"
            if let position = position {
                command += " \(position)"
            }
            if let nbt = nbt {
                command += " \(nbt)"
            }
            return command
        }

        public var availability: Int { 4 }
    }
}
