public struct Align: ExecuteInstruction {
    let axes: [Minecraft.Commands.Execute.Axis]
    let instruction: ExecuteInstruction

    public init(
        axes: [Minecraft.Commands.Execute.Axis],
        @ExecuteInstructionBuilder _ instruction: () -> ExecuteInstruction
    ) {
        self.axes = axes
        self.instruction = instruction()
    }

    public var description: String { "align \(axes.map({ "\($0)" }).joined(separator: "")) \(instruction)"}
}

extension Minecraft.Commands.Execute {
    public enum Axis: String {
        case x, y, z
    }
}
