//
//  EarthAnimationCode.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import SwiftUI

struct EarthAnimationCode: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EarthAnimationCode_Previews: PreviewProvider {
    static var previews: some View {
        EarthAnimationCode()
    }
}
import SwiftUI

struct BlobsAnimation: View {
    @State private var blobSystem = BlobSystem()
    
    let blobSize: CGFloat = 35

    var body: some View {
        TimelineView(.animation) { timeline in
            ZStack {
                Canvas { context, size in
                    let time = timeline.date.timeIntervalSinceReferenceDate
                    blobSystem.update(date: time)
                
                    context.addFilter(.alphaThreshold(min: 0.3))
                    context.addFilter(.blur(radius: blobSize * 0.4))
                    
                    context.drawLayer { layer in
                        for particle in blobSystem.blobs {
                            if let resolvedSymbol = context.resolveSymbol(id: particle.id) {
                                layer.draw(resolvedSymbol, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: { symbols }
                .mask(Circle().frame(width: blobSize * 10, height: blobSize * 10))
                
                Circle()
                    .stroke(lineWidth: 5)
                    .frame(width: blobSize * 10, height: blobSize * 10)
            }
        }
    }

    var symbols: some View {
        ForEach(blobSystem.blobs, id: \.self) { blob in
            Circle()
                .frame(width: blobSize, height: blobSize)
                .offset(x: blob.x, y: blob.y)
                .tag(blob.id)
        }
    }
}

private struct Blob: Hashable {
    let id = UUID()
    var x: Double
    var y: Double
    let xOffset: CGFloat = CGFloat.random(in: -2...2)
    let yOffset: CGFloat = CGFloat.random(in: -2...2)
    let creationDate = Date.now.timeIntervalSinceReferenceDate
}

private class BlobSystem {
    var blobs: [Blob] = []
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            for _ in 0..<Int.random(in: 1...4) {
                self.blobs.append(Blob(x: 0, y: 0))
            }
        }
    }
    
    func update(date: TimeInterval) {
        let deathDate = date - 5
        
        for i in 0..<blobs.count {
            blobs[i].x += blobs[i].xOffset
            blobs[i].y += blobs[i].yOffset
        }
        
        for blob in blobs {
            if blob.creationDate < deathDate {
                blobs.removeAll(where: { $0.id == blob.id })
            }
        }
    }
}

struct BlobsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BlobsAnimation()
    }
}
