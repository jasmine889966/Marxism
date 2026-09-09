import SwiftUI

 
 
 
 
public struct HakoEmptyState<Icon: View>: View {
    public let title: String
    public let message: String
    public let isLoading: Bool

    private let icon: Icon

    public init(
        title: String,
        message: String,
        isLoading: Bool = false,
        @ViewBuilder icon: () -> Icon
    ) {
        self.title = title
        self.message = message
        self.isLoading = isLoading
        self.icon = icon()
    }

    public var body: some View {
        VStack(spacing: HakoTheme.Spacing.row) {
            if isLoading {
                ProgressView()
                    .controlSize(.large)
            } else {
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(SovietColors.red.opacity(0.08))
                        .frame(width: 76, height: 76)
                        .overlay {
                            if isDisconnected {
                                SovietBrandMark()
                                    .frame(width: 38, height: 38)
                                    .foregroundStyle(SovietColors.red)
                            } else if isMissingProfile {
                                Image(systemName: "doc.text")
                                    .font(.system(size: 30, weight: .medium))
                                    .foregroundStyle(SovietColors.red)
                            } else {
                                icon.font(.system(size: 30, weight: .medium))
                                    .foregroundStyle(SovietColors.red)
                            }
                        }
                    Image(systemName: "star.fill")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(SovietColors.gold)
                        .padding(5)
                        .background(SovietColors.surface, in: Circle())
                        .offset(x: 5, y: 5)
                }
                .padding(.bottom, 8)
                .accessibilityHidden(true)
            }

            Text(hako: .copy(title))
                .font(.title3.weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)

            Text(hako: .copy(message))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, HakoTheme.Spacing.section)
        .padding(.vertical, 40)
        .accessibilityElement(children: .combine)
    }
    private var isDisconnected: Bool {
        ["Clash Is Disconnected", "Clash is disconnected", "Not Connected", "Disconnected"].contains(title)
    }
    private var isMissingProfile: Bool {
        ["No Profile", "No Profiles", "No profiles yet"].contains(title)
    }
}
