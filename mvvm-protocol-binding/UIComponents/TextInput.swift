import SwiftUI
import Neumorphic

struct TextInputViewModel {
    let icon: String
    let placeholder: String
    let isSecureInput: Bool
    @Binding var text: String
}

struct TextInputView: View {

    let icon: String
    let placeholder: String
    let isSecureInput: Bool
    @Binding var text: String

    init(viewModel: TextInputViewModel) {
        self.icon = viewModel.icon
        self.placeholder = viewModel.placeholder
        self.isSecureInput = viewModel.isSecureInput
        self._text = viewModel.$text
    }

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Neumorphic.shared.secondaryColor())
                .font(Font.body.weight(.bold))
            if isSecureInput {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                    .accentColor(Neumorphic.shared.secondaryColor())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                    .accentColor(Neumorphic.shared.secondaryColor())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Neumorphic.shared.mainColor())
                .softInnerShadow(
                    RoundedRectangle(cornerRadius: 30),
                    darkShadow: Neumorphic.shared.darkShadowColor(),
                    lightShadow: Neumorphic.shared.lightShadowColor(),
                    spread: 0.05,
                    radius: 2
                )
        )
    }
}

extension TextInputViewModel {
    static func mock(icon: String = "person.fill",
                     placeholder: String = "Login",
                     isSecureInput: Bool = false,
                     text: Binding<String> = .constant("")) -> TextInputViewModel {
        return TextInputViewModel(
            icon: icon,
            placeholder: placeholder,
            isSecureInput: isSecureInput,
            text: text
        )
    }
}

struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextInputView(viewModel: TextInputViewModel.mock())
        }
    }
}
