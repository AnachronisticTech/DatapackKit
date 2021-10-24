import Foundation

public struct Advancement: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String
    let internalRepresentation: InternalRepresentation

    public init(
        _ name: String,
        title: String? = nil,
        description: String = "",
        frame: Frame = .task,
        showToast: Bool? = nil,
        announceToChat: Bool? = nil,
        hidden: Bool? = nil
    ) {
        self.name = name
        internalRepresentation = InternalRepresentation(
            display: DisplayOptions(
                title: title ?? name,
                description: description,
                frame: frame,
                showToast: showToast,
                announceToChat: announceToChat,
                hidden: hidden
            ),
            criteria: [],
            rewards: []
        )
    }

    public var description: String {
        """
          A \(name).json
            ----------------
              <advancement body here>
            ----------------
        """
    }

    public func build(at url: URL) throws {
        let buildUrl = url
            .appendingPathComponent("advancements")
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        try encoder.encode(internalRepresentation)
            .write(to: buildUrl.appendingPathComponent("\(name).json"), options: .atomic)
    }

    public enum Frame: String, Encodable {
        case task, goal, challenge
    }

    struct InternalRepresentation: Encodable {
        let display: DisplayOptions
        let criteria: [String]
        let rewards: [String]
    }

    struct DisplayOptions: Encodable {
        let title: String
        let description: String
        let frame: Frame?
        let showToast: Bool?
        let announceToChat: Bool?
        let hidden: Bool?
    }
}
