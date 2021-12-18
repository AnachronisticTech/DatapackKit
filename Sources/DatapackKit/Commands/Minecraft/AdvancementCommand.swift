extension Minecraft {
    public struct Advancement: Command {
        let players: [EntitySelector]
        let mode: Mode
        let variant: Variant

        init(players: [EntitySelector], _ mode: Mode, _ variant: Variant) {
            guard !players.map({ $0.playerType }).contains(false) else {
                fatalError("[ERROR] Advancement command may only be used with player entity selectors.")
            }
            guard !players.isEmpty else {
                fatalError("[ERROR] Advancement command may not be used without providing at least one player entity selector.")
            }
            self.players = players
            self.mode = mode
            self.variant = variant
        }

        public init(grantEverythingTo players: EntitySelector...) {
            self.init(players: players, .grant, .everything)
        }

        public init(revokeEverythingFrom players: EntitySelector...) {
            self.init(players: players, .revoke, .everything)
        }

        public init(
            grantOnly advancement: String,
            criterion: String? = nil,
            toTargets players: EntitySelector...
        ) {
            self.init(players: players, .grant, .only(advancement, criterion))
        }

        public init(
            revokeOnly advancement: String,
            criterion: String? = nil,
            fromTargets players: EntitySelector...
        ) {
            self.init(players: players, .revoke, .only(advancement, criterion))
        }

        public init(
            grantFrom advancement: String,
            toTargets players: EntitySelector...
        ) {
            self.init(players: players, .grant, .from(advancement))
        }

        public init(
            revokeFrom advancement: String,
            fromTargets players: EntitySelector...
        ) {
            self.init(players: players, .revoke, .from(advancement))
        }

        public init(
            grantThrough advancement: String,
            toTargets players: EntitySelector...
        ) {
            self.init(players: players, .grant, .through(advancement))
        }

        public init(
            revokeThrough advancement: String,
            fromTargets players: EntitySelector...
        ) {
            self.init(players: players, .revoke, .through(advancement))
        }

        public init(
            grantUntil advancement: String,
            toTargets players: EntitySelector...
        ) {
            self.init(players: players, .grant, .until(advancement))
        }

        public init(
            revokeUntil advancement: String,
            fromTargets players: EntitySelector...
        ) {
            self.init(players: players, .revoke, .until(advancement))
        }

        public var description: String {
            func targetsToString(_ targets: [EntitySelector]) -> String {
                return targets
                    .filter({ $0.playerType })
                    .map({ "\($0)" })
                    .joined(separator: " ")
            }

            var command = "advancement "
            switch variant {
                case .everything:
                    command += "\(mode) \(targetsToString(players)) everything"
                case let .only(advancement, criterion):
                    command += "\(mode) \(targetsToString(players)) only \(advancement)"
                    if let criterion = criterion {
                        command += " \(criterion)"
                    }
                case let .from(advancement):
                    command += "\(mode) \(targetsToString(players)) from \(advancement)"
                case let .through(advancement):
                    command += "\(mode) \(targetsToString(players)) through \(advancement)"
                case let .until(advancement):
                    command += "\(mode) \(targetsToString(players)) until \(advancement)"
            }
            return command
        }

        public var availability: Int { 4 }

        public enum Mode: String, RawRepresentable, CustomStringConvertible {
            case grant, revoke

            public var description: String { rawValue }
        }

        enum Variant {
            case everything
            case only(String, String? = nil)
            case from(String)
            case through(String)
            case until(String)
        }
    }
}