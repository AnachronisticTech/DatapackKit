extension Minecraft {
    public struct Datapack: Command {
        let variant: DatapackVariant

        public init(disable name: String) {
            variant = .disable(name)
        }

        public init(enable name: String, priority: EnablePriority? = nil) {
            variant = .enable(name, priority)
        }

        public init(list mode: ListMode) {
            variant = .list(mode)
        }

        public var description: String {
            switch variant {
                case let .disable(name): return "datapack disable \(name)"
                case let .enable(name, priority):
                    var command = "datapack enable \(name)"
                    if let priority = priority {
                        command += " \(priority)"
                    }
                    return command
                case let .list(mode): return "datapack list \(mode)"
            }
        }

        public var availability: Int { 4 }

        public enum ListMode: String, RawRepresentable, CustomStringConvertible {
            case available, enabled

            public var description: String { rawValue }
        }

        public enum EnablePriority: CustomStringConvertible {
            case first, last
            case before(String)
            case after(String)

            public var description: String {
                switch self {
                    case .first: return "first"
                    case .last: return "last"
                    case let .before(existing): return "before \(existing)"
                    case let .after(existing): return "after \(existing)"
                }
            }
        }

        enum DatapackVariant {
            case disable(String)
            case enable(String, EnablePriority?)
            case list(ListMode)
        }
    }
}
