public struct Vector3: Vector {
    let x: ScalarDistance
    let y: ScalarDistance
    let z: ScalarDistance

    public init(
        x: ScalarDistance,
        y: ScalarDistance,
        z: ScalarDistance
    ) {
        let fixedCount = [x, y, z]
            .filter { $0 == .local() }
            .count

        guard fixedCount == 0 || fixedCount == 3 else {
            fatalError("[ERROR] You cannot combine local coordinates with relative or absolute coordinates.")
        }

        self.x = x
        self.y = y
        self.z = z
    }

    public init(x: Int, y: Int, z: Int) {
        self.x = .absolute(x)
        self.y = .absolute(y)
        self.z = .absolute(z)
    }

    public static var zero: Vector3 { Vector3(x: 0, y: 0, z: 0) }
    public static var relativeZero: Vector3 { Vector3(x: .relative(), y: .relative(), z: .relative()) }

    public var description: String { "\(x) \(y) \(z)" }
}
