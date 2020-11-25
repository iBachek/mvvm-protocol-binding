import SwiftUI
import Neumorphic

struct StringItem: Identifiable {

    var id = UUID()
    let icon: String
    let string: String

    init(icon: String, string: String) {
        self.icon = icon
        self.string = string
    }
}

struct StringItemView: View {

    let item: StringItem

    public var body: some View {
        HStack {
            Image(systemName: item.icon)
                .foregroundColor(Neumorphic.shared.secondaryColor())
                .font(Font.body.weight(.heavy))
                .padding(.leading)

            Text(item.string)
                .foregroundColor(Neumorphic.shared.secondaryColor())
                .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                .padding(.leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Neumorphic.shared.mainColor())
                .softOuterShadow()
        )
    }
}

struct StringItemView_Previews: PreviewProvider {
    static var previews: some View {
        StringItemView(item: StringItem(icon: "terminal.fill",
                                        string: "w8TQiyOR"))
    }
}
