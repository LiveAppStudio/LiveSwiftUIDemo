//
//  LiveSwiftUIDemoApp.swift
//  LiveSwiftUIDemo
//
//  Created by 陈驰坤 on 2023/1/10.
//

import SwiftUI

@main
struct LiveSwiftUIDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        NavigationStack {
            PreviewsView(jsonData: Data())
        }
    }
}
