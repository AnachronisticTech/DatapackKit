import Foundation

@resultBuilder public struct MCNamespaceBuilder {
    public static func buildBlock(_ components: Function...) -> [Function] {
        components
    }
}

public struct Namespace: CustomStringConvertible {
    @KebabCase var name: String
    let functions: [Function]

    public init(
        _ name: String, 
        @MCNamespaceBuilder _ functions: () -> [Function]
    ) {
        self.name = name
        self.functions = functions()
    }

    public var description: String { 
        """
          - \(name)
        ------------------------
        \(functions.map({ "  \($0.name).mcfunction\n" }).joined().trimmingCharacters(in: .newlines))
        ------------------------
        """
    }
}
