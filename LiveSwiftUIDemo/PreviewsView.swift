//
//  PreviewsView.swift
//  LiveSwiftUIDemo
//
//  Created by 陈驰坤 on 2023/1/11.
//

import LiveSwiftUI

struct PreviewsView: View {
                 var jsonData: Data
    @StateObject var previewProvider: LSPreview
    
    init(jsonData json: Data) {
        self.jsonData = json
        self._previewProvider = StateObject(wrappedValue: LSPreview(project: json))
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .toolbar {
            ShareLink(item: LSProject(title: "你好", author: "haren724", version: "1.0", size: .iphone11, content: []), preview: SharePreview("AppStudio Project", icon: Image(systemName: "person")))
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
