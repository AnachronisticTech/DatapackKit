import Foundation

public struct Function: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String
    let commands: [Command]

    public var namespaceName: String = ""
    public var pathComponents: [String] = []
    public var parentAdvancement: [String] = []

    public init(
        _ name: String,
        @FunctionBuilder _ commands: (String) -> [Command]
    ) {
        self.name = name
        self.commands = commands(name.kebabCase())
    }

    public var description: String {
        """
          F \(name).mcfunction
            ----------------
        \(commands.map({ "      \($0)\n" }).joined().trimmingCharacters(in: .newlines))
            ----------------
        """
    }

    public func build(at url: URL) throws {
        var buildUrl = url.appendingPathComponent("functions")
        for pathComponent in pathComponents {
            buildUrl.appendPathComponent(pathComponent)
        }
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        try commands
            .map { "\($0)" }
            .joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .write(toFile: buildUrl.appendingPathComponent("\(name).mcfunction").relativePath, atomically: true, encoding: .utf8)

        try commands.forEach { command in
            let baseUrl = url.deletingLastPathComponent()
            if let command = command as? Convenience.After {
                try command.build(at: baseUrl)
            } else if let command = command as? Convenience.Every {
                try command.build(at: baseUrl)
                let commandUrl = baseUrl
                    .appendingPathComponent(command.namespaceName)
                    .appendingPathComponent("functions")
                    .appendingPathComponent(command.name)
                    .appendingPathExtension("mcfunction")
                var contents = try String(contentsOf: commandUrl)
                contents.append("\nschedule function \(command.namespaceName):\(command.name) \(command.time)")
                try contents.write(to: commandUrl, atomically: true, encoding: .utf8)
            }
        }
    }
}
