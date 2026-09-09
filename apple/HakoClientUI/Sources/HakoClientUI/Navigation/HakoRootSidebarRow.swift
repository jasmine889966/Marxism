import SwiftUI

 
 
 
 
 
public struct HakoRootSidebarRow<Icon: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    public let destination: HakoRootDestination
    public let isSelected: Bool
    public let minimumHeight: CGFloat
    public let horizontalPadding: CGFloat

    private let icon: Icon

    public init(
        destination: HakoRootDestination,
        isSelected: Bool,
        minimumHeight: CGFloat = HakoTheme.Control.minimumHitTarget,
        horizontalPadding: CGFloat = HakoTheme.Spacing.compact,
        @ViewBuilder icon: () -> Icon
    ) {
        self.destination = destination
        self.isSelected = isSelected
        self.minimumHeight = minimumHeight
        self.horizontalPadding = horizontalPadding
        self.icon = icon()
    }

    public var body: some View {
        Group {
            if dynamicTypeSize.isAccessibilitySize
                && HakoPlatformLayout.sidebarStacksLabelsAtAccessibilitySizes
            {
                VStack(
                    alignment: .leading,
                    spacing: HakoTheme.Spacing.compact
                ) {
                    sidebarIcon
                    title
                }
            } else {
                HStack(spacing: HakoTheme.Spacing.row) {
                    sidebarIcon
                    title
                    Spacer(minLength: HakoTheme.Spacing.compact)
                }
            }
        }
        .frame(minHeight: minimumHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding)
        .foregroundStyle(contentStyle)
        .background {
            RoundedRectangle(cornerRadius: SovietRadius.control)
                .fill(
                    isSelected
                        ? SovietColors.onRed.opacity(
                            HakoTheme.Opacity.regularSidebarSelection
                        )
                        : Color.clear
                )
        }
        .contentShape(Rectangle())
    }

    private var sidebarIcon: some View {
        Group {
            if destination == .home {
                SovietBrandMark()
            } else {
                Image(systemName: sidebarSymbol)
                    .font(.system(size: 21, weight: .medium))
            }
        }
        .frame(width: 24, height: 24)
        .foregroundStyle(isSelected ? SovietColors.sidebarGold : SovietColors.onRed.opacity(0.85))
        .accessibilityHidden(true)
    }

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    private var sidebarSymbol: String {
        switch destination {
        case .home: "star.fill"
        case .proxies: "network"
        case .rules: "point.3.connected.trianglepath.dotted"
        case .activity: "waveform.path"
        case .profiles: "doc.text"
        case .dns: "globe"
        case .utilities: "wrench.and.screwdriver"
        case .more: "slider.horizontal.3"
        case .about: "info.circle"
        }
    }

    private var contentStyle: AnyShapeStyle {
        AnyShapeStyle(SovietColors.onRed)
    }

    private var title: some View {
         
         
         
         
         
         
         
         
        HStack(spacing: 0) {
            Text(hako: .copy(destination.title))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(contentStyle)
#if os(macOS)
             
             
             
             
             
             
            if #available(macOS 15, *) {
                EmptyView()
            } else {
                Rectangle()
                    .fill(SovietColors.onRed.opacity(0.02))
                    .frame(width: 12, height: 12)
                    .accessibilityHidden(true)
            }
#endif
        }
    }
}
