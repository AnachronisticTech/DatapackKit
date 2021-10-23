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

    public func build(at url: URL? = nil) throws {
        var buildUrl: URL
        if let url = url {
            buildUrl = url
        } else if let url = FileManager.default.urls(for: .desktopDirectory, in: .allDomainsMask).first {
            buildUrl = url
        } else {
            throw DatapackKitError.buildPathError
        }

        buildUrl.appendPathComponent(packName.kebabCase())
        let mcmetaUrl = buildUrl.appendingPathComponent("pack.mcmeta")

        try? FileManager.default.removeItem(atPath: buildUrl.relativePath)
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        try mcmeta.write(to: mcmetaUrl, atomically: true, encoding: .utf8)
        for namespace in namespaces {
            try namespace.build(at: buildUrl)
        }

    }

    private var mcmeta: String {
        """
        {
            "pack": {
                "pack_format": \(packFormat),
                "description": "\(packName)"
            }
        }
        """
    }
}

public enum DatapackKitError: Error {
    case buildPathError
}

public enum PackFormat: Int, RawRepresentable, CustomStringConvertible {
    case v4 = 4
    case v5 = 5
    case v6 = 6
    case v7 = 7

    public var description: String { "\(rawValue)" }
}
