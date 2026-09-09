import SwiftUI
#if canImport(AppKit)
import AppKit
#else
import UIKit
#endif

/// Semantic surfaces shared by all Marxism platforms. Status colors remain semantic.
public enum SovietColors {
    public static let red = adaptive(0xC8102E, 0xF07887)
    public static let deepRed = adaptive(0x8B1018, 0x401A22)
    public static let accentRed = adaptive(0xD52727, 0xF07887)
    public static let canvas = adaptive(0xFAFAF8, 0x19191C)
    public static let surface = adaptive(0xF7F4EE, 0x252226)
    public static let card = adaptive(0xFFFFFF, 0x2C272C)
    public static let raisedFill = adaptive(0xEEE8DF, 0x393137)
    public static let separator = adaptive(0xA99D96, 0x9C898E)
    public static let text = adaptive(0x242424, 0xF7F4EE)
    public static let secondaryText = adaptive(0x707070, 0xBAB1B2)
    public static let gold = adaptive(0x866511, 0xD1A52B)
    public static let onRed = Color(red: 247/255, green: 244/255, blue: 238/255)
    public static let sidebarGold = Color(red: 232/255, green: 202/255, blue: 124/255)

    public static func canvas(pureBlack: Bool) -> Color {
        pureBlack ? adaptive(0xFAFAF8, 0x000000) : canvas
    }

    private static func adaptive(_ light: UInt32, _ dark: UInt32) -> Color {
        #if canImport(AppKit)
        return Color(nsColor: NSColor(name: nil) { appearance in
            let rgb = appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light
            return NSColor(srgbRed: Double((rgb >> 16) & 255)/255,
                           green: Double((rgb >> 8) & 255)/255,
                           blue: Double(rgb & 255)/255, alpha: 1)
        })
        #else
        return Color(uiColor: UIColor { traits in
            let rgb = traits.userInterfaceStyle == .dark ? dark : light
            return UIColor(red: Double((rgb >> 16) & 255)/255,
                           green: Double((rgb >> 8) & 255)/255,
                           blue: Double(rgb & 255)/255, alpha: 1)
        })
        #endif
    }
}

public enum SovietTypography {
    public static let brand = Font.title2.weight(.bold)
    public static let slogan = Font.footnote.weight(.medium)
    public static let telemetry = Font.body.monospacedDigit()
}
public enum SovietSpacing {
    public static let tight: CGFloat = 4
    public static let compact: CGFloat = 8
    public static let row: CGFloat = 12
    public static let standard: CGFloat = 16
    public static let section: CGFloat = 24
}
public enum SovietRadius {
    public static let control: CGFloat = 8
    public static let icon: CGFloat = 9
    public static let card: CGFloat = 16
    public static let section: CGFloat = 18
}
public enum SovietShadow {
    public static let opacity = 0.04
    public static let radius: CGFloat = 8
    public static let offset: CGFloat = 2
}
public enum SovietIconography {
    public static let connection = "network"
    public static let historicalAccent = "star.fill"
}
