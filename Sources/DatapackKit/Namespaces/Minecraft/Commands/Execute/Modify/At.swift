public struct At: ExecuteInstruction {
    let targets: EntitySelector
    let instruction: ExecuteInstruction

    public init(
        _ targets: EntitySelector,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.targets = targets
        self.instruction = instruction()
    }

    public var description: String { "at \(targets) \(instruction)"}
}
