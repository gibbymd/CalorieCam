import SwiftUI
import UIKit

class FoodRecognitionViewModel: ObservableObject {
    @Published var recognizedFoodItem: FoodItem?

    private let recognitionService = FoodRecognitionService()

    func recognizeFood(from image: UIImage) {
        recognitionService?.recognizeFood(from: image) { [weak self] name, confidence in
            DispatchQueue.main.async {
                if let name = name {
                    self?.recognizedFoodItem = FoodItem(
                        name: name,
                        estimatedCalories: 0, // You can update this later with real data
                        portionSize: "1 serving"
                    )
                } else {
                    print("❌ No food recognized.")
                }
            }
        }
    }
}
