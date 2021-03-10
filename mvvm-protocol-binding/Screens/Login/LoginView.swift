import SwiftUI
import Neumorphic

struct LoginView<ViewModel>: View where ViewModel: LoginViewModelProtocol {

    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Neumorphic.shared.colorScheme = colorScheme

        return Neumorphic.shared.mainColor()
            .ignoresSafeArea(.all)
            .overlay(
                VStack {
                    LoginView.Title(text: viewModel.title)
                        .padding(.top, 30)
                    Spacer()
                    VStack(spacing: 16) {
                        TextInputView(viewModel: viewModel.usernameModel)
                            .autocapitalization(.none)
                        TextInputView(viewModel: viewModel.passwordModel)
                    }
                    Spacer()
                    VStack {
                        ButtonView(viewModel: viewModel.loginButtonModel)
                        LoginView.AccessRestoration()
                    }
                    Spacer()
                    LoginView.Copyright()
                }
                .padding()
            )
            .dismissingKeyboardOnTap()
            .indicatorView(animating: $viewModel.isLoading)
            .alertView(isPresented: $viewModel.showAlert, viewModel: viewModel.alertViewModel)
    }

    struct Title: View {
        let text: String
        init(text: String) {
            self.text = text
        }

        var body: some View {
            Text(text)
                .font(.custom("Chalkduster", size: 41))
                .foregroundColor(Neumorphic.shared.secondaryColor())
        }
    }

    struct AccessRestoration: View {
        var body: some View {
            HStack {
                Text("Forgotten your login details?")
                    .font(.system(size: 11))
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                Text("Get help with signing in")
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundColor(Neumorphic.shared.secondaryColor())
            }
        }
    }

    struct Copyright: View {
        var body: some View {
            HStack {
                Text("Username:")
                    .font(.custom("AmericanTypewriter-Bold", size: 11))
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                Text("user")
                    .font(.custom("AmericanTypewriter", size: 11))
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                Text("Password:")
                    .font(.custom("AmericanTypewriter-Bold", size: 11))
                    .foregroundColor(Neumorphic.shared.secondaryColor())
                Text("123qwe")
                    .font(.custom("AmericanTypewriter", size: 11))
                    .foregroundColor(Neumorphic.shared.secondaryColor())
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModelMock.mock())
//            .environment(\.colorScheme, .light)
            .environment(\.colorScheme, .dark)
    }
}
