extension Minecraft {
    public struct Advancement: Command {
        let variant: Variant

        public init(grantEverythingTo targets: EntitySelector...) {
            variant = .everything(.grant, targets)
        }

        public init(revokeEverythingFrom targets: EntitySelector...) {
            variant = .everything(.revoke, targets)
        }

        public init(grantOnly advancement: String, criterion: String? = nil, toTargets targets: EntitySelector...) {
            variant = .only(.grant, targets, advancement, criterion)
        }

        public init(revokeOnly advancement: String, criterion: String? = nil, toTargets targets: EntitySelector...) {
            variant = .only(.revoke, targets, advancement, criterion)
        }

        public init(grantFrom advancement: String, toTargets targets: EntitySelector...) {
            variant = .from(.grant, targets, advancement)
        }

        public init(revokeFrom advancement: String, toTargets targets: EntitySelector...) {
            variant = .from(.revoke, targets, advancement)
        }

        public init(grantThrough advancement: String, toTargets targets: EntitySelector...) {
            variant = .through(.grant, targets, advancement)
        }

        public init(revokeThrough advancement: String, toTargets targets: EntitySelector...) {
            variant = .through(.revoke, targets, advancement)
        }

        public init(grantUntil advancement: String, toTargets targets: EntitySelector...) {
            variant = .until(.grant, targets, advancement)
        }

        public init(revokeUntil advancement: String, toTargets targets: EntitySelector...) {
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