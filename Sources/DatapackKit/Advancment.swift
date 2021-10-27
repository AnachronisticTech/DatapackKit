import Foundation

public struct Advancement: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String
    var internalRepresentation: InternalRepresentation
    var advancements: [Advancement]

    public init(
        _ name: String,
        title: String? = nil,
        description: String = "",
        frame: Frame = .task,
        showToast: Bool? = nil,
        announceToChat: Bool? = nil,
        hidden: Bool? = nil,
        @AdvancementChainBuilder _ advancements: () -> [Advancement] = { [] }
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
        self.advancements = advancements()
    }

    // Used for setting parent and namespace on child advancements
    internal init(
        name: String,
        display: DisplayOptions,
        parent: String,
        namespace: String,
        criteria: [String],
        rewards: [String],
        advancements: [Advancement] = []
    ) {
        self.name = name
        self.internalRepresentation = InternalRepresentation(
            display: display,
            parent: parent,
            namespace: namespace,
            criteria: criteria,
            rewards: rewards
        )
        self.advancements = advancements
    }

    public var description: String {
        """
          A \(name).json
            ----------------
        """
    }

    public func build(at url: URL, in namespace: String) throws {
        let buildUrl = url
            .appendingPathComponent("advancements")
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        try encoder.encode(internalRepresentation)
            .write(to: buildUrl.appendingPathComponent("\(name).json"), options: .atomic)

        // Used for setting parent and namespace on child advancements
        for advancement in advancements {
            let temp = Advancement(
                name: advancement.name,
                display: advancement.internalRepresentation.display,
                parent: name,
                namespace: namespace,
                criteria: advancement.internalRepresentation.criteria,
                rewards: advancement.internalRepresentation.rewards,
                advancements: advancement.advancements
            )
            try temp.build(at: url, in: namespace)
        }
    }

    public enum Frame: String, Encodable {
        case task, goal, challenge
    }

    struct InternalRepresentation: Encodable {
        let display: DisplayOptions
        var parent: String? = nil
        var namespace: String? = nil
        let criteria: [String]
        let rewards: [String]

        enum CodingKeys: CodingKey {
            case display, parent, criteria, rewards
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(display, forKey: .display)
            try container.encode(criteria, forKey: .criteria)
            try container.encode(rewards, forKey: .rewards)
            if let parent = parent, let namespace = namespace {
                try container.encode("\(namespace):\(parent)", forKey: .parent)
            }
        }
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
