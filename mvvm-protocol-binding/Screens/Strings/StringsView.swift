import SwiftUI
import Neumorphic

struct StringsView<ViewModel>: View where ViewModel: StringsViewModelProtocol {

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
                // Bug in SwiftUI related to the inability to remove List separators in iOS 14
                // Use ScrollView instead of List :(
                ScrollView {
                    VStack {
                        ForEach(viewModel.items) { item in
                            StringItemView(item: item)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.top)
            )
            .onAppear() {
                viewModel.viewOnAppear()
            }
            .indicatorView(animating: $viewModel.isLoading)
            .alertView(isPresented: $viewModel.showAlert, viewModel: viewModel.alertViewModel)
            // Animation on .onAppear() leads to UI lag
            .animation((viewModel.isLoading || viewModel.showAlert) ? .none : .easeInOut)
    }
}

struct StringsView_Previews: PreviewProvider {
    static var previews: some View {
        StringsView(viewModel: StringsViewModelMock.mock())
    }
}
