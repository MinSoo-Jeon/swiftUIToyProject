//
//  DimmedView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/29.
//

import SwiftUI

struct DimmedView: View {
    var body: some View {
        Color.black.opacity(0.5)
    }
}

struct DimmedView_Previews: PreviewProvider {
    static var previews: some View {
        DimmedView()
    }
}
