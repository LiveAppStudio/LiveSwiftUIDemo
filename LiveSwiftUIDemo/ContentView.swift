//
//  ContentView.swift
//  LiveSwiftUIDemo
//
//  Created by 陈驰坤 on 2023/1/10.
//

import SwiftUI
import LiveSwiftUI

struct ContentView: View {
    @State var jsonUrlString = ""
    @State var isLoading = false
    @State var didFail = false
    @State var previewWillLoad = false
    
    @State var fetchedData = Data()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Image(systemName: "square.and.arrow.up")
                        .padding()
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    Text("导入JSON文件以预览工程 (URL)")
                }
                .padding(.bottom, 50)
                TextField("https://", text: $jsonUrlString)
                    .padding(.bottom, 25)
                    .onTapGesture {
                        if self.jsonUrlString.isEmpty { jsonUrlString = "https://" }
                    }
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                Button("导入") {
                    Task { await jsonPreview() }
                }
                .buttonStyle(.borderedProminent)
                .alert("加载失败", isPresented: $didFail) {
                    Button("好") { }
                } message: {
                    Text("请检查你的网络联通性与链接的文件是否有效")
                }
                Spacer(); Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $previewWillLoad) { PreviewsView(jsonData: fetchedData) }
            .overlay {
                if isLoading {
                    VStack {
                        ProgressView()
                            .padding(.vertical)
                        Text("加载中")
                    }
                    .padding()
                    .frame(width: 120)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
            }
        }
    }
    
    func jsonPreview() async {
    //  ensure loading view can disappear after this function returns
        defer {
            withAnimation {
                isLoading = false
            }
        }
    //  show loading view
        withAnimation {
            isLoading = true
        }
        do {
            if let url =  URL(string: self.jsonUrlString) {
                let (data, response) = try await URLSession.shared.data(from: url)
                fetchedData = data
                print(response)
                previewWillLoad = true
            } else {
                throw URLError(.badURL)
            }
        } catch {
            didFail = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
