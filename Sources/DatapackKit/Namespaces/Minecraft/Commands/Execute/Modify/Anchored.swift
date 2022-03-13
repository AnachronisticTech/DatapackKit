public struct Anchored: ExecuteInstruction {
    let anchor: FacingAnchor
    let instruction: ExecuteInstruction

    public init(
        anchor: FacingAnchor,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.anchor = anchor
        self.instruction = instruction()
    }

    public var description: String { "anchored \(anchor) \(instruction)"}
}
