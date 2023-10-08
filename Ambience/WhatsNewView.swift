//
//  WhatsNewView.swift
//  Ambience
//
//  Created by Eugene Kovs on 02.09.2023.
//

import SwiftUI

import WhatsNewPack

struct WhatsNewView: View {
    
    let features: [Feature] = load(fileName: "New.json")
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WhatsNew(featureObject: features.first!, title: "What's new?", color: .purple, buttonTitle: "Continue", buttonColor: .blue, buttonCornerRadius: 20) {
            dismiss()
        }
    }
    
}
