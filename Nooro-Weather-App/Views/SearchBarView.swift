//
//  SearchBarView.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var queryText: String = ""
    
    private let onSubmitAction: (String) -> Void
    
    init(action: @escaping (String) -> Void) {
        self.onSubmitAction = action
    }
    
    var body: some View {
        TextField("Search Location", text: $queryText)
            .padding(.leading, 20)
            .padding(.trailing, 44)
            .padding(.vertical, 12)
            .frame(height: 46)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.grayF2F2F2)
                    
                    Image(systemName: "magnifyingglass")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 20)
                        .foregroundStyle(.grayC4C4C4)
                }
            )
            .submitLabel(.search)
            .onSubmit {
                onSubmitAction(queryText)
                queryText = ""
            }
    }
    
}

#Preview {
    SearchBarView(action: {_ in})
        .padding(.horizontal, 24)
}
