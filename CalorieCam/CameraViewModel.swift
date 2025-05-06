//
//  CameraViewModel.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//

import SwiftUI
import AVFoundation
import CoreML

class CameraViewModel: NSObject, ObservableObject {
    private var captureSession: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?

    @Published var capturedImage: UIImage?

    func setupCaptureSession(view: UIView) {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              let captureSession = captureSession else { return }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        photoOutput = AVCapturePhotoOutput()
        if let photoOutput = photoOutput, captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    func classifyCapturedImage() -> String? {
        guard let image = capturedImage else { return nil }

        guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.toCVPixelBuffer() else {
            return nil
        }

        do {
            let model = try SeeFood(configuration: MLModelConfiguration())
            let prediction = try model.prediction(image: buffer)
            return prediction.classLabel
        } catch {
            print("Prediction error: \(error)")
            return nil
        }
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }

        DispatchQueue.main.async {
            self.capturedImage = image
        }
    }
}

// MARK: - UIImage Resize Extension

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
}
