import SwiftUI
import Neumorphic

struct AlertViewModel {
    let title: String
    let message: String
    let dismissButton: ButtonViewModel
}

struct AlertView<Content>: View where Content: View {

    @Binding var isPresented: Bool
    let content: Content
    let viewModel: AlertViewModel

    var body: some View {
        ZStack {
            content
                .disabled(isPresented)
                .blur(radius: isPresented ? 3 : 0)
            VStack {
                VStack {
                    Text(viewModel.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text(viewModel.message)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .foregroundColor(Neumorphic.shared.secondaryColor())
                Divider()
                Button(
                    action: {
                        isPresented.toggle()
                        viewModel.dismissButton.action()
                    },
                    label: {
                        HStack {
                            Spacer()
                            Text(viewModel.dismissButton.title)
                                .fontWeight(.bold)
                                .foregroundColor(Neumorphic.shared.secondaryColor())
                            Spacer()
                        }
                    }
                )
                .padding(.top, 8)
                .padding(.bottom)
            }
            .cornerRadius(20)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Neumorphic.shared.mainColor())
                    .softOuterShadow()
            )
            .opacity(isPresented ? 1 : 0)
            .padding()
        }
    }
}

extension View {

    func alertView(isPresented: Binding<Bool>, viewModel: AlertViewModel) -> some View {
        AlertView(isPresented: isPresented, content: self, viewModel: viewModel)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .alertView(
                isPresented: .constant(true),
                viewModel: AlertViewModel.mock()
            )
            .padding()
    }
}

extension AlertViewModel {
    static func mock(title: String = "Error",
                     message: String = "Message",
                     dismissButton: ButtonViewModel = ButtonViewModel.mock()) -> AlertViewModel {
        return AlertViewModel(title: title, message: message, dismissButton: dismissButton)
    }
}

extension AlertViewModel {
    static func empty() -> AlertViewModel {
        return AlertViewModel(title: "", message: "", dismissButton: ButtonViewModel.empty())
    }
}
