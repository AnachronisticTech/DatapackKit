import Foundation

@resultBuilder public struct MCFunctionBuilder {
    public static func buildBlock(_ components: Command...) -> [Command] {
        components
    }

    public static func buildBlock(_ components: [Command]...) -> [Command] {
        components.flatMap({ $0 })
    }

    public static func buildArray(_ components: [[Command]]) -> [Command] {
        components.flatMap({ $0 })
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
          F \(name).mcfunction
            ----------------
        \(commands.map({ "      \($0)\n" }).joined().trimmingCharacters(in: .newlines))
            ----------------
        """
    }

    internal func build(at url: URL) throws {
        let buildUrl = url.appendingPathComponent("\(name).mcfunction")
        try commands
            .map { "\($0)" }
            .joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .write(toFile: buildUrl.relativePath, atomically: true, encoding: .utf8)
    }
}
