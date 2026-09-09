import SwiftUI

/// CC0 Soviet construction-sheet symbol. The native action and connection models remain unchanged.
public struct SovietBrandMark: View {
    public init() {}
    public var body: some View {
        SovietEmblem().fill()
            .aspectRatio(1, contentMode: .fit)
            .accessibilityHidden(true)
    }
}

public enum SovietCopy {
    public static let workers = "Workers of all countries, unite!"
    public static let electrification = "Communism is Soviet power plus the electrification of the whole country."
    public static let attribution = "Lenin, 1920"
    public static let derivative = "An unofficial derivative of TokenPLS/Hako-Client. Licensed under GPL-3.0."
}

/// Localized via the same app bundle and locale resolver as the existing UI.
public struct SovietHistoricalNote: View {
    private let sidebar: Bool
    public init(sidebar: Bool = false) { self.sidebar = sidebar }
    public var body: some View {
        VStack(alignment: .leading, spacing: SovietSpacing.compact) {
            Text(hako: .copy(SovietCopy.workers))
                .font(SovietTypography.slogan)
            if !sidebar {
                Text(hako: .copy(SovietCopy.electrification))
                    .font(.subheadline)
                Text(hako: .copy(SovietCopy.attribution))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .combine)
    }
}

public struct SovietHomeIdentity: View {
    public init() {}
    private var portraits: Image {
        #if os(tvOS)
        Image("SovietPortraits").renderingMode(.template)
        #else
        Image("SovietPortraits", bundle: .module).renderingMode(.template)
        #endif
    }
    public var body: some View {
        VStack(spacing: SovietSpacing.row) {
            portraits
                .resizable()
                .scaledToFit()
                .frame(width: 210, height: 162)
                .foregroundStyle(SovietColors.red)
                .accessibilityLabel(Text(hako: .copy("Karl Marx, Friedrich Engels and Vladimir Lenin")))
            Text("Marxism")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(SovietColors.text)
            Text(hako: .copy(SovietCopy.workers))
                .font(.title2.weight(.bold))
                .foregroundStyle(SovietColors.red)
                .fixedSize(horizontal: false, vertical: true)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, SovietSpacing.section)
        .padding(.bottom, SovietSpacing.row)
        .accessibilityIdentifier("home.marxism.identity")
    }
}

/// Presentation-only copy: never persist these labels in configurations or snapshots.
public enum SovietConnectionCopy {
    public static func action(_ action: HakoHomePrimaryAction, fallback: String) -> String {
        switch action {
        case .connect: return "Connect to communism"
        case .disconnect: return "Disconnect the link"
        case .cancel: return "Cancel the link"
        case .retry, .retryProxy: return "Rebuild the link"
        case .openProfiles: return "Configure the link"
        case .none: return fallback
        }
    }

    public static func state(_ connection: HakoHomeConnectionPresentation) -> String {
        switch connection.phase {
        case .noProfile: return "Prepare our connection"
        case .ready: return "Ready for international connection"
        case .connecting:
            return connection.primaryAction == .none ? "Closing the link" : "Establishing the link"
        case .connected: return "International connection established"
        case .switching: return "Switching communication lines"
        case .recoverableError: return "The link needs attention"
        case .directRecovery: return "Direct connection restored"
        }
    }
}
