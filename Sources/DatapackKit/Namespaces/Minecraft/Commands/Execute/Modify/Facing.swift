public struct Facing: ExecuteInstruction {
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
        entity: EntitySelector,
        anchor: FacingAnchor,
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        variant = .entity(entity, anchor)
        self.instruction = instruction()
    }

    public var description: String {
        var command = "facing "
        switch variant {
            case let .position(position):
                command += "\(position)"
            case let .entity(targets, facing):
                command += "entity \(targets) \(facing)"
        }
        return "\(command) \(instruction)"
    }

    enum Variant {
        case position(Vector3)
        case entity(EntitySelector, FacingAnchor)
    }
}
