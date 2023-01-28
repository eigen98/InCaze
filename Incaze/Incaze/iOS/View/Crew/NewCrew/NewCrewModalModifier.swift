//
//  NewCrewModalModifier.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import SwiftUI

struct NewCrewModalModifier: ViewModifier {

  @Binding var isPresented: Bool
  let title: String
  let message: String
  let primaryButtonTitle: String
    //(name: <#T##String#>, type: <#T##String#>, maxCount: <#T##Int#>, minimumGrade: <#T##String#>)
 let primaryAction: (String, String, Int, String) -> ()
  let withCancelButton: Bool

  init(
    isPresented: Binding<Bool>,
    title: String,
    message: String,
    primaryButtonTitle: String,
    primaryAction: @escaping (String, String, Int, String) -> Void,
    withCancelButton: Bool)
  {
    _isPresented = isPresented
    self.title = title
    self.message = message
    self.primaryButtonTitle = primaryButtonTitle
    self.primaryAction = primaryAction
    self.withCancelButton = withCancelButton
  }

  func body(content: Content) -> some View {
    ZStack {
      content

      ZStack {
        if isPresented {
          Rectangle()
            .fill(.black.opacity(0.3))
            .ignoresSafeArea()
            .transition(.opacity)
            
                
            NewCrewAlertView(
                isPresented: $isPresented,
              title: title,
              message: message,
              primaryButtonTitle: primaryButtonTitle,
              primaryAction: primaryAction,
              withCancelButton: withCancelButton)
          .transition(
            .asymmetric(
              insertion: .move(edge: .leading).combined(with: .opacity),
              removal: .move(edge: .trailing).combined(with: .opacity)))
        }
      }
      .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
  }
}

extension View {

    func showNewCrewModal(
      isPresented: Binding<Bool>,
      title: String,
      message: String,
      primaryButtonTitle: String,
      primaryAction: @escaping (String, String, Int, String) -> Void,
      withCancelButton: Bool) -> some View
    {
      modifier(
        NewCrewModalModifier(
          isPresented: isPresented,
          title: title,
          message: message,
          primaryButtonTitle: primaryButtonTitle,
          primaryAction: primaryAction,
          withCancelButton: withCancelButton))
    }
}

