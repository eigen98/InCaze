//
//  PagingTabView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import Foundation
import SwiftUI

struct PagingTabView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    
    
    func makeCoordinator() -> Coordinator {
        return PagingTabView.Coordinator(parent: self)
    }
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._offset = offset
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        
        
        let scrollView = UIScrollView()
        
        // SwiftUI 뷰를 UIKit을 이용하기 위해
        let hostview = UIHostingController(rootView: content)
        
        // 뷰 고정
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostview.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor ),
            hostview.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        // UIView에 SwiftUI View 통합
        scrollView.addSubview(hostview.view)
        scrollView.addConstraints(constraints)
        
        // 페이징 설정
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    // offset 받기 위해 delegate 설정
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PagingTabView
        
        init(parent: PagingTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // 오프셋 받는 부분
            let offset = scrollView.contentOffset.x
            
            parent.offset = offset
        }
    }
    
}
