//
//  ContentView.swift
//  password_manager
//
//  Created by Jay on 15/07/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = PasswordViewModel()
    @State private var showaddeditView = false
    @State private var selectedEntry : PasswordEntry?
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    Button(action: {
                        selectedEntry = entry
                        showaddeditView = true
                    }) {
                        VStack(alignment: .leading) {
                            Text("\(entry.name) ********").font(.headline)
//                            Text(entry.email).font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteEntry)
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Password Manager")
            .navigationBarItems(trailing: Button(action: {
                selectedEntry = nil
                showaddeditView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showaddeditView) {
                AddEditPasswordView(viewModel: viewModel, entry: selectedEntry)
            }
            
            
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

@main
struct PasswordManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
