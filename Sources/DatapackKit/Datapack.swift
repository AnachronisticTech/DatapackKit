import Foundation

@resultBuilder public struct MCDatapackBuilder {
    public static func buildBlock(_ components: Namespace...) -> [Namespace] {
        components
    }
}

public struct Datapack: CustomStringConvertible {
    let packName: String
    let packFormat: PackFormat
    let namespaces: [Namespace]

    public init(
        packName: String,
        packFormat: PackFormat,
        @MCDatapackBuilder _ namespaces: () -> [Namespace]
    ) {
        self.packName = packName
        self.packFormat = packFormat
        self.namespaces = namespaces()
    }

    public var description: String {
        """
        Pack name: \(packName.kebabCase())
        Description: \(packName)
        Format: \(packFormat)
        ====================
        \(namespaces.map({ "\($0)\n" }).joined().trimmingCharacters(in: .newlines))
        ====================
        """
    }
}

public enum PackFormat: Int, RawRepresentable, CustomStringConvertible {
    case v4 = 4
    case v5 = 5
    case v6 = 6
    case v7 = 7

    public var description: String { "\(rawValue)" }
}
