extension Minecraft.Commands {
    public struct Datapack: Command {
        let variant: Variant

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
            var command = "datapack "
            switch variant {
                case let .disable(name):
                    command += "disable \(name)"
                case let .enable(name, priority):
                    command += "enable \(name)"
                    if let priority = priority {
                        command += " \(priority)"
                    }
                case let .list(mode):
                    command += "list \(mode)"
            }
            return command
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

        enum Variant {
            case disable(String)
            case enable(String, EnablePriority?)
            case list(ListMode)
        }
    }
}
