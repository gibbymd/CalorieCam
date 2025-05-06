import Foundation
import CoreML
import UIKit

class FoodRecognitionService {
    private let model: SeeFood

    init?() {
        do {
            self.model = try SeeFood(configuration: MLModelConfiguration())
        } catch {
            print("❌ Failed to load SeeFood model: \(error)")
            return nil
        }
    }

    func recognizeFood(from image: UIImage, completion: @escaping (String?, Double?) -> Void) {
        guard let pixelBuffer = image.toCVPixelBuffer() else {
            print("❌ Failed to convert image to CVPixelBuffer.")
            completion(nil, nil)
            return
        }

        do {
            let prediction = try model.prediction(image: pixelBuffer)
            completion(prediction.classLabel, 1.0) // SeeFood may not return confidence
        } catch {
            print("❌ Prediction failed: \(error)")
            completion(nil, nil)
        }
    }
}
