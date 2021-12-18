extension Minecraft {
    public struct Teleport: Command {
        let variant: Variant

        public init(to entity: EntitySelector) {
            variant = .destination(entity)
        }

        public init(
            _ entity: EntitySelector,
            to targetEntity: EntitySelector
        ) {
            variant = .targetDestination(entity, targetEntity)
        }

        public init(to location: Vector3) {
            variant = .location(location)
        }

        public init(
            _ entity: EntitySelector,
            to location: Vector3
        ) {
            variant = .tLocation(entity, location)
        }

        public init(
            _ entity: EntitySelector,
            to location: Vector3,
            withRotation rotation: Vector2
        ) {
            variant = .tLocationRotation(entity, location, rotation)
        }

        public init(
            _ entity: EntitySelector,
            to location: Vector3,
            facing: Vector3
        ) {
            variant = .tLocationFacing(entity, location, facing)
        }

        public init(
            _ entity: EntitySelector,
            to location: Vector3,
            facing: EntitySelector,
            anchor: FacingAnchor? = nil
        ) {
            variant = .tLocationFacingEntity(entity, location, facing, anchor)
        }

        public var description: String {
            var command = "teleport "
            switch variant {
                case let .destination(entity):
                    command += "\(entity)"
                case let .targetDestination(target, destination):
                    command += "\(target) \(destination)"
                case let .location(location):
                    command += "\(location)"
                case let .tLocation(entity, location):
                    command += "\(entity) \(location)"
                case let .tLocationRotation(entity, location, rotation):
                    command += "\(entity) \(location) \(rotation)"
                case let .tLocationFacing(entity, location, facing):
                    command += "\(entity) \(location) facing \(facing)"
                case let .tLocationFacingEntity(entity, location, facing, anchor):
                    command += "\(entity) \(location) facing entity \(facing)\(anchor != nil ? " \(anchor!)" : "")"
            }
            return command
        }

        public var availability: Int { 4 }

        enum Variant {
            case destination(EntitySelector)
            case targetDestination(EntitySelector, EntitySelector)
            case location(Vector)
            case tLocation(EntitySelector, Vector)
            case tLocationRotation(EntitySelector, Vector, Vector)
            case tLocationFacing(EntitySelector, Vector, Vector)
            case tLocationFacingEntity(EntitySelector, Vector, EntitySelector, FacingAnchor?)
        }
    }
}
