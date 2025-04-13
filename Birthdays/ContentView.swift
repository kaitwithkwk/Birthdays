//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 4/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                    .onTapGesture {
                        selectedFriend = friend
                    }
                }
                .onDelete(perform: deleteFriend)
            }

            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = Date.now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
    
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
