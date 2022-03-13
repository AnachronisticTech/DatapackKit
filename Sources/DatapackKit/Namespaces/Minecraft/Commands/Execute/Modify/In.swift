public struct In: ExecuteInstruction {
    let dimension: String
    let instruction: ExecuteInstruction

    public init(
        _ dimension: String,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.dimension = dimension
        self.instruction = instruction()
    }

    public var description: String { "in \(dimension) \(instruction)"}
}
