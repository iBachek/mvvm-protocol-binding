import SwiftUI
import Neumorphic

struct ButtonViewModel {
    let title: String
    let action: () -> Void

    init(title: String, action: @escaping () -> Void = { }) {
        self.title = title
        self.action = action
    }
}

struct ButtonView: View {

    let title: String
    let action: () -> Void

    init(viewModel: ButtonViewModel) {
        self.title = viewModel.title
        self.action = viewModel.action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title).fontWeight(.bold)
                Spacer()
            }
        }
        .softButtonStyle(RoundedRectangle(cornerRadius: 30))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView(viewModel: ButtonViewModel.mock())
        }
    }
}

extension ButtonViewModel {
    static func mock(title: String = "Button",
                     action: @escaping () -> Void = {}) -> ButtonViewModel {
        return ButtonViewModel(title: title, action: action)
    }
}

extension ButtonViewModel {
    static func empty() -> ButtonViewModel {
        return ButtonViewModel(title: "", action: {})
    }
}
