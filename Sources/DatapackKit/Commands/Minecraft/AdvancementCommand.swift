extension Minecraft {
    public struct Advancement: Command {
        let variant: Variant

        public init(grantEverythingTo targets: EntitySelector...) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .everything(.grant, targets)
        }

        public init(revokeEverythingFrom targets: EntitySelector...) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .everything(.revoke, targets)
        }

        public init(
            grantOnly advancement: String,
            criterion: String? = nil,
            toTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .only(.grant, targets, advancement, criterion)
        }

        public init(
            revokeOnly advancement: String,
            criterion: String? = nil,
            fromTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .only(.revoke, targets, advancement, criterion)
        }

        public init(
            grantFrom advancement: String,
            toTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .from(.grant, targets, advancement)
        }

        public init(
            revokeFrom advancement: String,
            fromTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .from(.revoke, targets, advancement)
        }

        public init(
            grantThrough advancement: String,
            toTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .through(.grant, targets, advancement)
        }

        public init(
            revokeThrough advancement: String,
            fromTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .through(.revoke, targets, advancement)
        }

        public init(
            grantUntil advancement: String,
            toTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .until(.grant, targets, advancement)
        }

        public init(
            revokeUntil advancement: String,
            fromTargets targets: EntitySelector...
        ) {
            guard !targets.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !targets.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            variant = .until(.revoke, targets, advancement)
        }

        public var description: String {
            func targetsToString(_ targets: [EntitySelector]) -> String {
                return targets.filter({ $0.playerType }).map({ "\($0)" }).joined(separator: " ")
            }
            var command = "advancement "
            switch variant {
                case let .everything(mode, targets):
                    command += "\(mode) \(targetsToString(targets)) everything"
                case let .only(mode, targets, advancement, criterion):
                    command += "\(mode) \(targetsToString(targets)) only \(advancement)"
                    if let criterion = criterion {
                        command += " \(criterion)"
                    }
                case let .from(mode, targets, advancement):
                    command += "\(mode) \(targetsToString(targets)) from \(advancement)"
                case let .through(mode, targets, advancement):
                    command += "\(mode) \(targetsToString(targets)) through \(advancement)"
                case let .until(mode, targets, advancement):
                    command += "\(mode) \(targetsToString(targets)) until \(advancement)"
            }
            return command
        }

        public var availability: Int { 4 }

        public enum Mode: String, RawRepresentable, CustomStringConvertible {
            case grant, revoke

            public var description: String { rawValue }
        }

        enum Variant {
            case everything(Mode, [EntitySelector])
            case only(Mode, [EntitySelector], String, String? = nil)
            case from(Mode, [EntitySelector], String)
            case through(Mode, [EntitySelector], String)
            case until(Mode, [EntitySelector], String)
        }
    }
}