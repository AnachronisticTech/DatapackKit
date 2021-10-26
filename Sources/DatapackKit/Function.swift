import Foundation

public struct Function: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String
    let commands: [Command]

    public init(
        _ name: String,
        @FunctionBuilder _ commands: () -> [Command]
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

    public func build(at url: URL, in namespace: String) throws {
        let buildUrl = url
            .appendingPathComponent("functions")
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        try commands
            .map { "\($0)" }
            .joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .write(toFile: buildUrl.appendingPathComponent("\(name).mcfunction").relativePath, atomically: true, encoding: .utf8)
    }
}
