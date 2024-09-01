//
//  GuidedView.swift
//  OnboardingKit
//
//  Created by Gavin Gichini on 9/1/24.
//

import SwiftUI

struct GuidedView<Content: View>: View {
    @AppStorage("onboarding_complete")
    var onboardingComplete: Bool = false
    
    let features: [OnboardingFeature]?
    let privacyDescription: LocalizedStringKey
    let privacyURL: URL
    let content: Content
    
    init(features: [OnboardingFeature], privacyDescription: LocalizedStringKey, privacyURL: URL, @ViewBuilder content: () -> Content) {
        self.features = features
        self.privacyDescription = privacyDescription
        self.privacyURL = privacyURL
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            if !onboardingComplete {
                OnboardingView(features: features, privacyDescription: privacyDescription, privacyURL: privacyURL)
            }
        }
    }
}

#Preview {
    GuidedView(
        features: [
            OnboardingFeature(
                "Preview your apps",
                systemImage: "iphone.gen3.motion",
                description: "You can easily preview your apps on a variety of devices."
            ),
            OnboardingFeature(
                "Verify different situations",
                systemImage: "questionmark.app.dashed",
                description: "Previews how your app looks when things are different."
            )
        ],
        privacyDescription: "\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "OBKIT_BUNDLE_NAME") collects usage data including your device identifier, app version, and language. By selecting continue, you agree to the privacy policy.",
        privacyURL: URL(string: "https://www.apple.com/privacy")!
    ) {
        NavigationStack {
            Text("Hello, World!")
                .navigationTitle("Guided View Example")
        }
    }
}
