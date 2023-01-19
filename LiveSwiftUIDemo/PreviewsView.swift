//
//  PreviewsView.swift
//  LiveSwiftUIDemo
//
//  Created by 陈驰坤 on 2023/1/11.
//

import SwiftUI
import LiveSwiftUI

struct PreviewsView: View {
                 var jsonData: Data
    @StateObject var previewProvider: LSPreview
    
    init(jsonData json: Data) {
        self.jsonData = json
        self._previewProvider = StateObject(wrappedValue: LSPreview(project: json))
        let navibarAppearance = UINavigationBarAppearance()
        navibarAppearance.configureWithOpaqueBackground()
        navibarAppearance.backgroundColor = .secondarySystemBackground
        UINavigationBar.appearance().standardAppearance = navibarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navibarAppearance
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .toolbar {
            ShareLink(item: LSProject(title: "你好", author: "haren724", version: "1.0", size: .iphone11, content: []), preview: SharePreview("AppStudio Project\nnihao", icon: Image("AppIcon")))
        }
    }
}

struct PreviewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PreviewsView(jsonData: Data())
        }
    }
}
