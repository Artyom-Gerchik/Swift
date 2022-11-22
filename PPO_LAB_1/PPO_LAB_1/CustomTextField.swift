import SwiftUI

struct HideKeyboardTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<HideKeyboardTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.inputView = UIView()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<HideKeyboardTextField>) {
        uiView.text = text
    }
    
    
    func makeCoordinator() -> HideKeyboardTextField.Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: HideKeyboardTextField

        init(parent: HideKeyboardTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
    }
}
