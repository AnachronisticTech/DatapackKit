public struct Rotated: ExecuteInstruction {
    let variant: Variant
    let instruction: ExecuteInstruction

    public init(
        _ yaw: Double,
        _ pitch: Double,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        variant = .rotation(yaw, pitch)
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
        var command = "rotated "
        switch variant {
            case let .rotation(yaw, pitch):
                command += "\(yaw) \(pitch)"
            case let .entity(targets):
                command += "as \(targets)"
        }
        return "\(command) \(instruction)"
    }

    enum Variant {
        case rotation(Double, Double)
        case entity(EntitySelector)
    }
}
