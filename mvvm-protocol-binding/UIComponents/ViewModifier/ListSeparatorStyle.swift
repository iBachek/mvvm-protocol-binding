import SwiftUI

struct ListSeparatorStyle: ViewModifier {

    let style: UITableViewCell.SeparatorStyle

    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = style
            }
    }
}

extension View {

    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}
