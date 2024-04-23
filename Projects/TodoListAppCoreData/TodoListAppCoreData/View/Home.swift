//
//  Home.swift
//  TodoListAppCoreData
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI

struct Home: View {
    @Environment(\.self) private var env
    
    @State private var filterDate: Date = .init()
    @State private var showPendingTasks: Bool = true
    @State private var showCompletedTasks: Bool = true
    var body: some View {
        List {
            DatePicker(selection: $filterDate, displayedComponents: [.date]) {
                
            }
            .labelsHidden()
            .datePickerStyle(.graphical)
            
            DisclosureGroup(
                isExpanded: $showPendingTasks,
                content: {
                    CustomFilteringDataView(displayPendingTask: true, filterDate: filterDate) {
                        TaskRow(task: $0, isPendingTask: true)
                    }
                },
                label: {
                    Text("Pending Task's")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            )
            
            DisclosureGroup(
                isExpanded: $showCompletedTasks,
                content: {
                    CustomFilteringDataView(displayPendingTask: false, filterDate: filterDate) {
                        TaskRow(task: $0, isPendingTask: false)
                    }
                },
                label: {
                    Text("Completed Task's")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            )
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    do {
                        let task = Task(context: env.managedObjectContext)
                        task.id = .init()
                        task.date = filterDate
                        task.title = ""
                        task.isCompleted = false
                        
                        try env.managedObjectContext.save()
                        showPendingTasks = true
                    }catch {
                        print(error.localizedDescription)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        
                        Text("New Task")
                        
                    }
                    .fontWeight(.bold)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct TaskRow: View {
    @ObservedObject var task: Task
    var isPendingTask: Bool
    
    @Environment(\.self) private var env
    @FocusState private var showKeyboard: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                task.isCompleted.toggle()
                save()
            }, label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(.blue)
                
            })
            .buttonStyle(.plain)
            
            VStack (alignment: .leading, spacing: 4){
                TextField("Task Title", text: .init(get: {
                    return task.title ?? ""
                }, set: { value in
                    task.title = value
                }))
                .focused($showKeyboard)
                .onSubmit {
                    removeEmptyTask()
                    save()
                }
                .foregroundStyle(isPendingTask ? .primary : Color(.gray))
                .strikethrough(!isPendingTask, pattern: .dash, color: .primary)
                
                Text((task.date ?? .init()).formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .overlay {
                        DatePicker(selection: .init(get: {
                            return task.date ?? .init()
                        }, set: { date in
                            task.date = date
                            save()
                        }), displayedComponents: [.hourAndMinute]) {
                            
                        }
                        .labelsHidden()
                        .blendMode(.destinationOver)
                    }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            if (task.title ?? "").isEmpty {
                showKeyboard = true
            }
        }
        .onChange(of: env.scenePhase) { oldValue, newValue in
            if newValue != .active {
                //checking if it's empty
              
                removeEmptyTask()
                
                save()
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    env.managedObjectContext.delete(task)
                    save()
                }
               
            } label: {
                Image(systemName: "trash.fill")
            }

        }
    }
    
    //context saving method
    func save(){
        do {
            try env.managedObjectContext.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func removeEmptyTask(){
        //checking if it's empty
        if (task.title ?? "").isEmpty {
            env.managedObjectContext.delete(task)
        }
        
    }
}
