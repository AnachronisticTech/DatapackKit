public struct Positioned: ExecuteInstruction {
    let variant: Variant
    let instruction: ExecuteInstruction

    public init(
        _ position: Vector3,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        variant = .position(position)
        self.instruction = instruction()
    }

    public init(
        as targets: EntitySelector,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        variant = .entity(targets)
        self.instruction = instruction()
    }

    public var description: String {
        var command = "positioned "
        switch variant {
            case let .position(position):
                command += "\(position)"
            case let .entity(targets):
                command += "as \(targets)"
        }
        return "\(command) \(instruction)"
    }

    enum Variant {
        case position(Vector3)
        case entity(EntitySelector)
    }
}
