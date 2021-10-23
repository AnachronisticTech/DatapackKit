import Foundation

public protocol NamespaceComponent {
    func build(at url: URL) throws
}

public struct Namespace: CustomStringConvertible {
    @KebabCase var name: String
    let components: [NamespaceComponent]

    public init(
        _ name: String, 
        @NamespaceBuilder _ components: () -> [NamespaceComponent]
    ) {
        self.name = name
        self.components = components()
    }

    public var description: String { 
        """
          N \(name)
          ------------------
        \(components.map({ "  \($0)\n" }).joined().trimmingCharacters(in: .newlines))
          ------------------
        """
    }

    internal func build(at url: URL) throws {
        let buildUrl = url
            .appendingPathComponent("data")
            .appendingPathComponent(name)
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        for function in components {
            try function.build(at: buildUrl)
        }
    }
}
