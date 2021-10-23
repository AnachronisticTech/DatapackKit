@resultBuilder public struct FunctionBuilder {
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
