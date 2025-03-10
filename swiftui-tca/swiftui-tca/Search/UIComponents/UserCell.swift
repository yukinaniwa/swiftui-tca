import SwiftUI

struct UserCell: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .padding()
            
            Spacer()
            
            Text(user.login)
                .padding()
       }
    }
}

#Preview {
    UserCell(user: User(
        login: "yukinaniwa",
        avatarUrl: "https://avatars.githubusercontent.com/u/6525578?v=4",
        reposUrl: "https://api.github.com/users/yukinaniwa/repos"))
}
