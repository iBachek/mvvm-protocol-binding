import SwiftUI
import Neumorphic

struct IndicatorView<Content>: View where Content: View {

    @Binding var animating: Bool
    let content: Content

    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ZStack(alignment: .center) {
                content
                    .disabled(animating)
                    .blur(radius: animating ? 3 : 0)
                VStack {
                    Text("Loading...")
                    ActivityIndicator(animating: $animating, style: .large)
                }
                .frame(
                    width: geometry.size.width / 2,
                    height: geometry.size.height / 5
                )
                .foregroundColor(Neumorphic.shared.secondaryColor())
                .cornerRadius(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Neumorphic.shared.mainColor())
                        .softOuterShadow()
                )
                .opacity(animating ? 1 : 0)
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var animating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.animating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

extension View {

    func indicatorView(animating: Binding<Bool>) -> some View {
        IndicatorView(animating: animating, content: self)
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .indicatorView(animating: .constant(true))
            .padding()
    }
}
