extension Minecraft {
    public struct Say: Command {
        let message: String

        public init(_ message: String) {
            self.message = message
        }

        public var description: String { "say \(message)" }

        public var availability: Int { 4 }
    }
}
