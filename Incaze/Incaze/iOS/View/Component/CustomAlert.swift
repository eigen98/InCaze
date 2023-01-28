//
//  CustomAlert.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/26.
//

import SwiftUI

import SwiftUI

struct CustomAlert: View {

  @Binding var isPresented: Bool
  let title: String
  let message: String
  let primaryButtonTitle: String
  let primaryAction: () -> Void
  let withCancelButton: Bool

  var body: some View {
    VStack(spacing: 12) {
      Text(title)
        .foregroundColor(.black)
        .font(.title3)
        .bold()

      Text(message)
        .foregroundColor(.black)
        .multilineTextAlignment(.leading)
        .frame(minHeight: 60)

      Divider()

      HStack {
        if withCancelButton {
          Button(action: { isPresented = false }) {
            Text("취소")
              .padding(.vertical, 6)
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.bordered)
          .tint(.cyan)
        }

        Button {
          primaryAction()
          isPresented = false
        } label: {
          Text(primaryButtonTitle)
            .bold()
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.cyan)
      }
    }
    .padding(16)
    .frame(width: 300)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .stroke(.cyan.opacity(0.5))
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(.white)
        )
    )
  }
}

struct CustomAlert_Previews: PreviewProvider {
  static var previews: some View {
    CustomAlert(
      isPresented: .constant(true),
      title: "타이틀",
      message: "메시지메시지메시지~",
      primaryButtonTitle: "확인!",
      primaryAction: { },
      withCancelButton: true)
  }
}
