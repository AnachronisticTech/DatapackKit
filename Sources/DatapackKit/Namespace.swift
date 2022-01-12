import Foundation

public protocol NamespaceComponent {
    var namespaceName: String { get set }
    var pathComponents: [String] { get set }
    var parentAdvancement: [String] { get set }
    
    func build(at url: URL) throws
}

public class Namespace: CustomStringConvertible {
    @KebabCase var name: String
    let components: [NamespaceComponent]

    public init(
        _ name: String, 
        @NamespaceBuilder _ components: (String) -> [NamespaceComponent]
    ) {
        self.name = name
        self.components = components(name.kebabCase())
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
        for var component in components {
            component.namespaceName = name
            try component.build(at: buildUrl)
        }
    }
}
