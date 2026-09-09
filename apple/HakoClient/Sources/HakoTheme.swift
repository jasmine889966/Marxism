import SwiftUI
import HakoClientUI
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

 
 
enum HakoTheme {
    static var canvas: Color { canvas(pureBlack: AppPreferences.pureBlack()) }

    static func canvas(pureBlack: Bool) -> Color { SovietColors.canvas(pureBlack: pureBlack) }
    static let surface = SovietColors.surface
    static let raisedFill = SovietColors.raisedFill
    static let separator = SovietColors.separator
    static let card = SovietColors.card

    enum Spacing {
        static let tight = HakoClientUI.HakoTheme.Spacing.tight
        static let compact = HakoClientUI.HakoTheme.Spacing.compact
        static let row = HakoClientUI.HakoTheme.Spacing.row
        static let standard = HakoClientUI.HakoTheme.Spacing.standard
        static let section = HakoClientUI.HakoTheme.Spacing.section
    }

     
     
     
    enum Typography {
        static func rowSubtitle(_ locale: Locale) -> Font {
            HakoClientUI.HakoTheme.Typography.rowSubtitle(locale)
        }

        static func rowSubtitleGap(_ locale: Locale) -> CGFloat {
            HakoClientUI.HakoTheme.Typography.rowSubtitleGap(locale)
        }
    }

    enum Radius {
        static let control = HakoClientUI.HakoTheme.Radius.control
        static let icon = HakoClientUI.HakoTheme.Radius.icon
        static let card = HakoClientUI.HakoTheme.Radius.card
         
         
        static let groupedSection = HakoClientUI.HakoTheme.Radius.groupedSection
        static let liquidGlassCard = HakoClientUI.HakoTheme.Radius.liquidGlassCard
    }

    enum Layout {
         
         
        static let primaryPageGlassBleed = HakoClientUI.HakoTheme.Layout.primaryPageGlassBleed
    }
}

extension HakoClientUI.HakoProductPalette {
     
     
     
     
     
     
     
     
     
    static var hakoProduct: HakoClientUI.HakoProductPalette {
#if os(macOS)
        HakoClientUI.HakoProductPalette(
            canvas: HakoTheme.canvas,
            surface: HakoTheme.surface,
            raisedFill: HakoTheme.raisedFill,
            separator: HakoTheme.separator,
            card: HakoTheme.card
        )
#else
        HakoClientUI.HakoProductPalette(
            canvas: HakoTheme.canvas,
            surface: HakoTheme.surface,
            raisedFill: HakoTheme.raisedFill,
            separator: HakoTheme.separator
        )
#endif
    }
}
