public protocol ExecuteInstruction: CustomStringConvertible {}

extension Minecraft.Commands {
    public struct Execute: Command {
        let instruction: ExecuteInstruction

        public init(@ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction) {
            self.instruction = instruction()
        }

        public var description: String {
            "execute \(instruction)"
        }

        public var availability: Int { 0 }
    }
}
