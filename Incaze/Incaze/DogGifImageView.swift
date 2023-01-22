//
//  DogGifImageView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/09.
//

import SwiftUI
import WebKit

struct DogGifImageView: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct DogGifImageView_Previews: PreviewProvider {
    static var previews: some View {
        DogGifImageView("giphy-unscreen")
    }
}
