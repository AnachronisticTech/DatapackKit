import DatapackKit

@main
struct DatapackCreator {
    static func main() {
        let players = ["Alex", "Steve", "Homer"]
        let pack = Datapack(packName: "Build Jam Pack", packFormat: .v7) {
            Namespace("  Nam espace_1  ") {
                Function(" mY Funct ion") {
                    Minecraft.Say("Hello \(EntitySelector.allPlayers)")
                    Minecraft.Teleport(
                        .namedPlayer("DTM5397"),
                        to: Vector3(x: .relative(), y: .relative(2), z: .absolute(-5))
                    )

                    Minecraft.Teleport(
                        .namedPlayer("DTM5397"),
                        to: Vector3(x: .local(-20), y: .local(2), z: .local(-5))
                    )

                    Minecraft.Teleport(
                        .executor,
                        to: Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        withRotation: Vector2(x: .absolute(0), z: .absolute(0))
                    )

                    Minecraft.Teleport(
                        .allEntites,
                        to:  Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        facing: .nearestPlayer
                    )

                    Minecraft.Teleport(
                        .allPlayers,
                        to:  Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        facing: .executor,
                        anchor: .eyes
                    )

                    Minecraft.Gamemode(.creative)

                    Minecraft.Say("Hello \(EntitySelector.executor)")
                }
                Function("myFunc2") {
                    Minecraft.Gamemode(.adventure)
                    Convenience.Raw("setblock \(Vector3(x: .relative(), y: .relative(), z: .relative(-1))) air")
                    Minecraft.Team(modify: "myTeam", [.friendlyFire(false), .collisionRule(), .color(.black)])
                }
                Advancement("MyAdvancment", icon: "minecraft:stone", title: "Advancement title!!!", description: "A custom advancment", frame: .goal, showToast: false, announceToChat: true, hidden: false) {
                    Advancement("Nested advancement", icon: "minecraft:cobblestone")
                }
            }

            Namespace("NewNamespace") {
                Function("teleportInGrid") {
                    for x in stride(from: -32, through: 32, by: 16) {
                        for z in stride(from: -32, through: 32, by: 16) {
                            Minecraft.Teleport(.executor, to: Vector3(x: .absolute(x), y: .relative(), z: .absolute(z)))
                        }
                    }
                }
            }

            Namespace("Hello Functions") {
                for player in players {
                    Function("greeting\(player)") {
                        for remaining in players.filter({ $0 != player }) {
                            Minecraft.Say("hi \(remaining)")
                        }
                    }
                }
            }
        }

        do {
            try pack.build()
        } catch {
            print(error)
        }
    }
}
