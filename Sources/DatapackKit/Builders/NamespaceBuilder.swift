@resultBuilder public struct NamespaceBuilder {
    public static func buildBlock(_ components: NamespaceComponent...) -> [NamespaceComponent] {
        components
    }

    public static func buildBlock(_ components: [NamespaceComponent]...) -> [NamespaceComponent] {
        components.flatMap({ $0 })
    }

    public static func buildArray(_ components: [[NamespaceComponent]]) -> [NamespaceComponent] {
        components.flatMap({ $0 })
    }

    public static func buildExpression(_ expression: NamespaceComponent) -> [NamespaceComponent] {
        [expression]
    }
}
