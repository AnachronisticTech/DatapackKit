import DatapackKit

@main
struct DatapackCreator {
    static func main() {
        let players = ["Alex", "Steve", "Homer"]
        let pack = Datapack("Build Jam Pack", format: .v7) {
            Namespace("  Nam espace_1  ") { _ in
                Function(" mY Funct ion") { _ in
                    Convenience.After(seconds: 10) {
                        Minecraft.Commands.Say("This is an async function!")
                        Minecraft.Commands.Say("Changing gamemode to creative")
                        Minecraft.Commands.Gamemode(.creative)
                    }

                    Minecraft.Commands.Say("Hello \(EntitySelector.allPlayers())")
                    Minecraft.Commands.Teleport(
                        .namedPlayer("DTM5397"),
                        to: Vector3(x: .relative(), y: .relative(2), z: .absolute(-5))
                    )

                    Minecraft.Commands.Teleport(
                        .namedPlayer("DTM5397"),
                        to: Vector3(x: .local(-20), y: .local(2), z: .local(-5))
                    )

                    Minecraft.Commands.Teleport(
                        .executor(),
                        to: Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        withRotation: Vector2(x: .absolute(0), z: .absolute(0))
                    )

                    Minecraft.Commands.Teleport(
                        .allEntities([.x(5), .z(-3), .distanceRange(9...12)]),
                        to:  Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        facing: .nearestPlayer()
                    )

                    Minecraft.Commands.Teleport(
                        .allPlayers(),
                        to:  Vector3(x: .relative(1), y: .absolute(5), z: .relative()),
                        facing: .executor(),
                        anchor: .eyes
                    )

                    Minecraft.Commands.Gamemode(.creative)

                    Minecraft.Commands.Say("Hello \(EntitySelector.executor())")
                }
                Function("myFunc2") { _ in
                    Minecraft.Commands.Gamemode(.adventure)
                    Convenience.Raw("setblock \(Vector3(x: .relative(), y: .relative(), z: .relative(-1))) air")
                    Minecraft.Commands.Team(modify: "myTeam", .friendlyFire(false), .collisionRule(), .color(.black))
                }
                Folder("rootFolder") { _ in
                    Advancement("MyAdvancement",
                        icon: "minecraft:stone",
                        title: "Advancement title!!!",
                        description: "A custom advancement",
                        frame: .goal,
                        showToast: false,
                        announceToChat: true,
                        hidden: false
                    ) {
                        Folder("testFolder") { _ in
                            Advancement("Nested advancement", icon: "minecraft:cobblestone")
                                .icon("minecraft:cobblestone")
                                .frame(.challenge)
                                .showToast(true)
                                .announceToChat(false)
                                .isHidden(true)
                            Function("readyForEnchanting") { _ in
                                Minecraft.Commands.Experience(addLevels: 30, to: .allPlayers())
                            }
                        }
                    }
                    .title("Better Advancement Title")
                    .description("This advancement now has a more detailed description.")
                }
            }

            Namespace("NewNamespace") { _ in
                Function("teleportInGrid") { _ in
                    for x in stride(from: -32, through: 32, by: 16) {
                        for z in stride(from: -32, through: 32, by: 16) {
                            Minecraft.Commands.Teleport(.executor(), to: Vector3(x: .absolute(x), y: .relative(), z: .absolute(z)))
                        }
                    }
                }

                for player in players {
                    Function("greeting\(player)") { _ in
                        for remaining in players.filter({ $0 != player }) {
                            Minecraft.Commands.Say("hi \(remaining)")
                        }
                    }
                }
            }
        }

        // print(pack)
        do {
            try pack.build()
        } catch {
            print(error)
        }
    }
}
