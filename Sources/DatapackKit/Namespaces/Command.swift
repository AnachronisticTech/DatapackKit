import Foundation

public protocol Command: CustomStringConvertible {
    var availability: Int { get }
}
