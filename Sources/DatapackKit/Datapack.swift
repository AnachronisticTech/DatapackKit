import Foundation

public struct Datapack: CustomStringConvertible {
    @KebabCase var name: String
    let packDescription: String
    let format: PackFormat
    let namespaces: [Namespace]

    public init(
        _ name: String,
        packDescription: String? = nil,
        format: PackFormat,
        @DatapackBuilder _ namespaces: () -> [Namespace]
    ) {
        self.packDescription = packDescription ?? name
        self.name = name
        self.format = format
        self.namespaces = namespaces()
    }

    public var description: String {
        """
        Pack name: \(name.kebabCase())
        Description: \(name)
        Format: \(format)
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

        buildUrl.appendPathComponent(name)
        let mcmetaUrl = buildUrl.appendingPathComponent("pack.mcmeta")

        if FileManager.default.fileExists(atPath: buildUrl.relativePath) {
            try FileManager.default.removeItem(atPath: buildUrl.relativePath)
        }
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
                "pack_format": \(format),
                "description": "\(packDescription)"
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
