# DatapackKit

A Swift library for writing and generating Minecraft datapacks.

## Benefits:
- Use programming features like iterations and conditionals
- Automatic pack generation (no need to remember the file structure)
- Strongly-typed commands to ensure correct mcFunctions
- Declarative syntax for writing packs, namespaces, and functions

## Natively supported commands

<details>
<summary>Click to show list</summary>

- [ ] ? help
- [x] advancement
- [ ] attribute
- [x] ban
  ```swift
  // Syntax
  Minecraft.Ban(
      _ players: EnitiySelector..., // variadic list of player entity selectors (must provide at least one)
      reason: String? = nil // optional ban message
  )

  // Examples
  // Ban all players
  Minecraft.Ban(.allPlayers)

  // Ban two named players, providing reason
  Minecraft.Ban(.namedPlayer("Alex"), .namedPlayer("Steve"), reason: "Disorderly conduct")
  ```
- [ ] ban-ip
- [ ] banlist
- [ ] bossbar
- [ ] clear
- [x] clone
- [ ] data
- [x] datapack
- [ ] debug
- [ ] defaultgamemode
- [ ] deop
- [ ] difficulty
- [ ] effect
- [ ] enchant
- [ ] execute
- [x] experience xp
- [ ] fill
- [ ] forceload
- [ ] function
- [x] gamemode
- [ ] gamerule
- [ ] give
- [ ] item
- [ ] jfr
- [ ] kick
- [ ] kill
- [ ] list
- [ ] locate
- [ ] locatebiome
- [ ] loot
- [ ] me
- [ ] msg tell w
- [ ] op
- [ ] pardon
- [ ] pardon-ip
- [ ] particle
- [ ] perf
- [ ] playsound
- [ ] publish
- [ ] recipe
- [ ] reload
- [ ] save-all
- [ ] save-off
- [ ] save-on
- [x] say
- [ ] schedule
- [ ] scoreboard
- [ ] seed
- [ ] setblock
- [ ] setidletimeout
- [ ] setworldspawn
- [ ] spawnpoint
- [ ] spectate
- [ ] spreadplayers
- [ ] stop
- [ ] stopsound
- [ ] summon
- [ ] tag
- [x] team
- [ ] teammsg tm
- [x] teleport tp
- [ ] tellraw
- [ ] time
- [ ] title
- [ ] trigger
- [ ] weather
- [ ] whitelist
- [ ] worldborder

</details>
