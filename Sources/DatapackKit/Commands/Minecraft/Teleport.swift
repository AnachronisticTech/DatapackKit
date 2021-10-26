extension Minecraft {
    public struct Teleport: Command {
        let variant: TeleportVariant

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
            switch variant {
                case let .destination(entity): 
                    return "tp \(entity)"
                case let .targetDestination(target, destination): 
                    return "tp \(target) \(destination)"
                case let .location(location): 
                    return "tp \(location)"
                case let .tLocation(entity, location): 
                    return "tp \(entity) \(location)"
                case let .tLocationRotation(entity, location, rotation): 
                    return "tp \(entity) \(location) \(rotation)"
                case let .tLocationFacing(entity, location, facing): 
                    return "tp \(entity) \(location) facing \(facing)"
                case let .tLocationFacingEntity(entity, location, facing, anchor): 
                    return "tp \(entity) \(location) facing entity \(facing)\(anchor != nil ? " \(anchor!)" : "")"
            }
        }

        public var availability: Int {
            switch variant {
                default: return 4
            }
        }

        enum TeleportVariant {
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
