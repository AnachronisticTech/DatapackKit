import Foundation

public struct Datapack: Codable, Equatable {
    let description: String
    let packFormat: Int

    var pack: InternalDataPackRepresentation

    public init(description: String, packFormat: Int) {
        self.description = description
        self.packFormat = packFormat
        pack = InternalDataPackRepresentation(
            description: description, 
            packFormat: packFormat
        )
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pack = try container.decode(InternalDataPackRepresentation.self, forKey: .pack)
        self.description = pack.description
        self.packFormat = pack.packFormat
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pack, forKey: .pack)
    }

    public static func ==(lhs: Datapack, rhs: Datapack) -> Bool {
        lhs.description == rhs.description && lhs.packFormat == rhs.packFormat
    }

    enum CodingKeys: CodingKey {
        case pack
    }

    struct InternalDataPackRepresentation: Codable {
        let description: String
        let packFormat: Int

        enum CodingKeys: String, CodingKey {
            case description
            case packFormat = "pack_format"
        }
    }
}
