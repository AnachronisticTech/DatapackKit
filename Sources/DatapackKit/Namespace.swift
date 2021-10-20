import Foundation

@resultBuilder public struct MCNamespaceBuilder {
    public static func buildBlock(_ components: Function...) -> [Function] {
        components
    }

    public static func buildBlock(_ components: [Function]...) -> [Function] {
        components.flatMap({ $0 })
    }

    public static func buildArray(_ components: [[Function]]) -> [Function] {
        components.flatMap({ $0 })
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
          N \(name)
          ------------------
        \(functions.map({ "  \($0)\n" }).joined().trimmingCharacters(in: .newlines))
          ------------------
        """
    }
}
