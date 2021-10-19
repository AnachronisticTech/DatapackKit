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
            withRotation rotation: Vector3
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
            facing: EntitySelector
        ) {
            variant = .tLocationFacingEntity(entity, location, facing)
        }

        public var description: String {
            switch variant {
                case let .destination(entity): 
                    return "tp \(entity)"
                case let .targetDestination(target, destination): 
                    return "tp \(target) \(destination)"
                case let .location(location): 
                    return "tp \(location.x) \(location.y) \(location.z)"
                case let .tLocation(entity, location): 
                    return "tp \(entity) \(location.x) \(location.y) \(location.z)"
                case let .tLocationRotation(entity, location, rotation): 
                    return "tp \(entity) \(location.x) \(location.y) \(location.z) \(rotation.x) \(rotation.y) \(rotation.z)"
                case let .tLocationFacing(entity, location, facing): 
                    return "tp \(entity) \(location.x) \(location.y) \(location.z) \(facing.x) \(facing.y) \(facing.z)"
                case let .tLocationFacingEntity(entity, location, facing): 
                    return "tp \(entity) \(location.x) \(location.y) \(location.z) \(facing)"
            }
        }

        enum TeleportVariant {
            case destination(EntitySelector)
            case targetDestination(EntitySelector, EntitySelector)
            case location(Vector3)
            case tLocation(EntitySelector, Vector3)
            case tLocationRotation(EntitySelector, Vector3, Vector3)
            case tLocationFacing(EntitySelector, Vector3, Vector3)
            case tLocationFacingEntity(EntitySelector, Vector3, EntitySelector)
        }
    }
}
