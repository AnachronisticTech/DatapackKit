extension Convenience {
    public struct Raw: Command {
        let command: String

        public init(_ command: String) {
            self.command = command
        }

        public var description: String { command }

        public var availability: Int { 4 }
    }
}
