import SwiftUI
import AVFoundation
import CoreML

struct CameraView: View {
    @StateObject var cameraViewModel = CameraViewModel()
    @State private var predictionLabel: String?

    var body: some View {
        VStack {
            Text("Capture Food Image")
                .font(.title)

            CameraPreview(cameraViewModel: cameraViewModel)
                .frame(height: 300)

            if let image = cameraViewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            }

            if let label = predictionLabel {
                Text("Prediction: \(label)")
                    .font(.headline)
                    .padding()
            }

            Button(action: {
                cameraViewModel.capturePhoto()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    predictionLabel = cameraViewModel.classifyCapturedImage()
                }
            }) {
                Text("Capture")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

// MARK: - CameraPreview

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraViewModel: CameraViewModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraViewModel.setupCaptureSession(view: view)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
