extension Minecraft.Commands {
    public struct Function: Command {
        @KebabCase var name: String
        @KebabCase var namespaceName: String

        public init(
            _ name: String,
            inNamespace namespaceName: String
        ) {
            self.name = name
            self.namespaceName = namespaceName
        }

        public var description: String {
            "function \(namespaceName):\(name)"
        }

        public var availability: Int { 4 }

        internal var identifier: String {
            "\(namespaceName):\(name)"
        }
    }
}
