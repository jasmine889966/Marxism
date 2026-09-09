import SwiftUI

 
 
 
 
 
struct HakoTVWelcomeView: View {
    let onAddSubscription: () -> Void
     
     
    var restoreLine: String? = nil
    var onRestore: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 24) {
            HakoTVBrandMark()
            Text("Marxism")
                .font(.largeTitle.weight(.bold))
            Text(SovietCopy.workers.localizedForTelevision)
                .font(.title3.weight(.bold))
                .foregroundStyle(SovietColors.red)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 900)
            if restoreLine != nil {
                Text("Your iPhone or Mac keeps profiles in iCloud: restore them here, or add one by its address.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 900)
            } else {
            Text("Add a profile to get started. Type its address here, or on your iPhone when the keyboard appears there.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 900)
            }
            if let restoreLine, let onRestore {
                Button(restoreLine, action: onRestore)
                    .padding(.top, 12)
                Button("Configure the link", action: onAddSubscription)
            } else {
                Button("Configure the link", action: onAddSubscription)
                    .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
         
         
         
         
         
    }
}
