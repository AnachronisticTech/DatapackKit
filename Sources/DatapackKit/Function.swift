import Foundation

@resultBuilder public struct MCFunctionBuilder {
    public static func buildBlock(_ components: Command...) -> [Command] {
        components
    }
}

public struct Function: CustomStringConvertible {
    @KebabCase var name: String
    let commands: [Command]

    public init(
        _ name: String,
        @MCFunctionBuilder _ commands: () -> [Command]
    ) {
        self.name = name
        self.commands = commands()
    }

    public var description: String {
        """
          - \(name).mcfunction
        ------------------------
        \(commands.map({ "  \($0)\n" }).joined().trimmingCharacters(in: .newlines))
        ------------------------
        """
    }
}
