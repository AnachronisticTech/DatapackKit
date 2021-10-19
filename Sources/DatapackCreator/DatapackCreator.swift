import DatapackKit

@main
struct DatapackCreator {
    static func main() {
        let function = Function("myFunc") {
            Minecraft.Teleport(
                .namedPlayer("DTM5397"),
                to: Vector3(x: .relative(), y: .relative(2), z: .absolute(-5))
            )

            Minecraft.Teleport(
                .namedPlayer("DTM5397"),
                to: Vector3(x: .local(-20), y: .local(2), z: .local(-5))
            )

            Minecraft.Teleport(.executor, to: Vector2(x: .absolute(0), z: .absolute(0)), withRotation: Vector3(x: .relative(1), y: .absolute(5), z: .relative()))

            Minecraft.Gamemode(.creative)

            Minecraft.Say("Hello \(EntitySelector.executor)")
        }

        print(function)

        let namespace = Namespace("myNamespace") {
            function
        }

        print(namespace)
    }
}
