import SwiftUI

public enum HakoAccentRole: String, CaseIterable, Sendable {
    case blue
    case cyan
    case green
    case indigo
    case orange
    case pink
    case purple
    case teal

    public var color: Color {
        switch self {
        case .blue: SovietColors.red
        case .cyan: SovietColors.red
        case .green: .green
        case .indigo: SovietColors.red
        case .orange: .orange
        case .pink: SovietColors.red
        case .purple: SovietColors.red
        case .teal: SovietColors.red
        }
    }
}
