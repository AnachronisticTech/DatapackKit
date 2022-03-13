public struct Run: ExecuteInstruction {
    let command: Command

    public init(@CommandBuilder _ command: () -> Command) {
        self.command = command()
    }

    public var description: String {
        "run \(command)"
    }
}
