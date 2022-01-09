extension Minecraft.Scoreboard {
    public struct Objectives: Command {
        let variant: Variant

        init(variant: Variant) {
            self.variant = variant
        }

        public init() {
            self.init(variant: .list)
        }

        public init(
            add objective: String,
            criteria: String,
            displayName: String? = nil
        ) {
            self.init(variant: .add(objective, criteria, displayName))
        }

        public init(remove objective: String) {
            self.init(variant: .remove(objective))
        }

        public init(
            setDisplay slot: Slot,
            forObjective objective: String? = nil
        ) {
            self.init(variant: .setDisplay(slot, objective))
        }

        public init(
            modify objective: String,
            displayName: String
        ) {
            self.init(variant: .modifyDisplayName(objective, displayName))
        }

        public init(
            modify objective: String,
            renderType: RenderType
        ) {
            self.init(variant: .modifyRenderType(objective, renderType))
        }

        public var description: String {
            var command = "scoreboard objectives "
            switch variant {
                case .list:
                    command += "list"
                case let .add(objective, criteria, displayName):
                    command += "add \(objective) \(criteria)"
                    if let displayName = displayName {
                        command += " \"\(displayName)\""
                    }
                case let .remove(objective):
                    command += "remove \(objective)"
                case let .setDisplay(slot, objective):
                    command += "setdisplay \(slot)"
                    if let objective = objective {
                        command += " \(objective)"
                    }
                case let .modifyDisplayName(objective, displayName):
                    command += "modify \(objective) displayname \"\(displayName)\""
                case let .modifyRenderType(objective, renderType):
                    command += "modify \(objective) rendertype \(renderType.rawValue)"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case list
            case add(String, String, String? = nil)
            case remove(String)
            case setDisplay(Slot, String? = nil)
            case modifyDisplayName(String, String)
            case modifyRenderType(String, RenderType)
        }

        public enum Slot: CustomStringConvertible {
            case list, sidebar
            case sidebarTeam(Color)

            public var description: String {
                switch self {
                    case .list: return "list"
                    case .sidebar: return "sidebar"
                    case let .sidebarTeam(color): return "sidebar.team.\(color.rawValue.kebabCase())"
                }
            }
        }

        public enum RenderType: String {
            case hearts, integer
        }
    }
}
