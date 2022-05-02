import Foundation

public class Advancement: CustomStringConvertible, NamespaceComponent {
    @KebabCase var name: String
    var internalRepresentation: InternalRepresentation
    var components: [NamespaceComponent]

    public var namespaceName: String = ""
    public var pathComponents: [String] = []
    public var parentAdvancement: [String] = []

    public init(
        _ name: String,
        icon: String,
        title: String? = nil,
        description: String = "",
        frame: Frame = .task,
        showToast: Bool? = nil,
        announceToChat: Bool? = nil,
        hidden: Bool? = nil,
        @NamespaceBuilder _ components: () -> [NamespaceComponent] = { [] }
    ) {
        self.name = name
        internalRepresentation = InternalRepresentation(
            display: DisplayOptions(
                title: title ?? name,
                icon: icon,
                description: description,
                frame: frame,
                showToast: showToast,
                announceToChat: announceToChat,
                hidden: hidden
            ),
            criteria: [],
            rewards: []
        )
        self.components = components()
    }

    public var description: String {
        """
          A \(name).json
            ----------------
        """
    }

    public func build(at url: URL) throws {
        var buildUrl = url.appendingPathComponent("advancements")
        for pathComponent in pathComponents {
            buildUrl.appendPathComponent(pathComponent)
        }
        if !parentAdvancement.isEmpty {
            internalRepresentation.namespace = namespaceName
            internalRepresentation.parent = parentAdvancement.joined(separator: "/")
        }
        try FileManager.default.createDirectory(atPath: buildUrl.relativePath, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        if #available(macOS 10.13, *) {
            encoder.outputFormatting.update(with: .sortedKeys)
        }
        if #available(macOS 10.15, *) {
            encoder.outputFormatting.update(with: .withoutEscapingSlashes)
        }
        try encoder.encode(internalRepresentation)
            .write(to: buildUrl.appendingPathComponent("\(name).json"), options: .atomic)

        for var component in components {
            component.namespaceName = namespaceName
            component.pathComponents = pathComponents
            component.parentAdvancement = pathComponents + [name]
            try component.build(at: url)
        }
    }

    public enum Frame: String, Encodable {
        case task, goal, challenge
    }

    struct InternalRepresentation: Encodable {
        var display: DisplayOptions
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
        var title: String
        var icon: String
        var description: String
        var frame: Frame?
        var showToast: Bool?
        var announceToChat: Bool?
        var hidden: Bool?

        var _icon: Icon {
            get { Icon(item: icon) }
            set { icon = newValue.item }
        }

        struct Icon: Encodable {
            let item: String
        }

        enum CodingKeys: String, CodingKey {
            case title, description, frame
            case showToast, announceToChat, hidden
            case _icon = "icon"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(title, forKey: .title)
            try container.encode(_icon, forKey: ._icon)
            try container.encode(description, forKey: .description)
            try container.encodeIfPresent(frame, forKey: .frame)
            try container.encodeIfPresent(showToast, forKey: .showToast)
            try container.encodeIfPresent(announceToChat, forKey: .announceToChat)
            try container.encodeIfPresent(hidden, forKey: .hidden)
        }
    }
}

public extension Advancement {
    func title(_ title: String) -> Self {
        internalRepresentation.display.title = title
        return self
    }

    func description(_ description: String) -> Self {
        internalRepresentation.display.description = description
        return self
    }
    func icon(_ icon: String) -> Self {
        internalRepresentation.display.icon = icon
        return self
    }

    func frame(_ frame: Frame) -> Self {
        internalRepresentation.display.frame = frame
        return self
    }

    func showToast(_ toast: Bool) -> Self {
        internalRepresentation.display.showToast = toast
        return self
    }

    func announceToChat(_ announceToChat: Bool) -> Self {
        internalRepresentation.display.announceToChat = announceToChat
        return self
    }

    func isHidden(_ hidden: Bool) -> Self {
        internalRepresentation.display.hidden = hidden
        return self
    }
}
