import Foundation

public struct Advancement: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String

    public init(_ name: String) {
        self.name = name
    }

    public var description: String {
        """
          A \(name).json
            ----------------
              <advancement body here>
            ----------------
        """
    }

    public func build(at url: URL) throws {
        let buildUrl = url
            .appendingPathComponent("advancements")
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        try "{}"
            .write(toFile: buildUrl.appendingPathComponent("\(name).json").relativePath, atomically: true, encoding: .utf8)
    }
}
