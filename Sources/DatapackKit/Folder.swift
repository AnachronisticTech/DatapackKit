import Foundation

public class Folder: NamespaceComponent {
    @KebabCase var name: String
    var components: [NamespaceComponent]

    public var namespaceName: String = ""
    public var pathComponents: [String] = []
    public var parentAdvancement: [String] = []

    public init(
        _ name: String,
        @NamespaceBuilder _ components: () -> [NamespaceComponent] = { [] }
    ) {
        self.name = name
        self.components = components()
    }

    public func build(at url: URL) throws {
        for var component in components {
            component.namespaceName = namespaceName
            component.pathComponents = pathComponents + [name]
            component.parentAdvancement = parentAdvancement
            try component.build(at: url)
        }
    }
}
