///
///This code is taken from  Gist https://gist.github.com/warrenm/f4f1c7f7e71bd88fc3d3df95b60d5f04
///

import Foundation
import SceneKit
import SceneKit.ModelIO

class ARQLThumbnailGenerator {
    private let device = MTLCreateSystemDefaultDevice()!

    /// Create a thumbnail image of the asset with the specified URL at the specified
    /// animation time. Supports loading of .scn, .usd, .usdz, .obj, and .abc files,
    /// and other formats supported by ModelIO.
    /// - Parameters:
    ///     - url: The file URL of the asset.
    ///     - size: The size (in points) at which to render the asset.
    ///     - time: The animation time to which the asset should be advanced before snapshotting.
    func thumbnail(for url: URL, size: CGSize, time: TimeInterval = 0) -> UIImage? {
        let renderer = SCNRenderer(device: device, options: [:])
        renderer.autoenablesDefaultLighting = true

        if (url.pathExtension == "scn") {
            let scene = try? SCNScene(url: url, options: nil)
            renderer.scene = scene
        } else {
            let asset = MDLAsset(url: url)
            let scene = SCNScene(mdlAsset: asset)
            renderer.scene = scene
        }

        let image = renderer.snapshot(atTime: time, with: size, antialiasingMode: .multisampling4X)
        return image
    }
}
