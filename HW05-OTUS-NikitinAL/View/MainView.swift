//
//  MainView.swift
//  HW05-OTUS-NikitinAL
//
//  Created by Александр Никитин on 27.04.2023.
//

import SwiftUI


struct MainView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var selectPicker : SelectForPicker = .all
   
    var body: some View {
        
        VStack {
            TextField("Текст для разделения на суффиксы", text: $vm.text)
                .padding()
                .border(.secondary)
                .padding(.horizontal)
           
            Picker("Picker", selection: $selectPicker) {
                ForEach(SelectForPicker.allCases) { item in
                    Text(item.rawValue.capitalized)
                    
                }
                
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selectPicker {
                case .all:
                    FirstView()
                case .top:
                    SecondView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}

struct FirstView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var suffixSortBy: suffixSort = .ASC
    
    var body: some View {
        VStack {
            List(vm.sortedSuffixes, id:\.key) { key, value in
                HStack{
                    Text(key)
                    Spacer()
                    Text("\(value)")
                }
            }
            .listStyle(.plain)
            
            Button {
                suffixSortBy = suffixSortBy == .ASC ? .DESC : .ASC
                vm.sortSuffixes(by: suffixSortBy)
                
            } label: {
                Text(suffixSortBy == .ASC ? "ASC" : "DESC")
            }
        }
    }
}

struct SecondView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack {
            List(vm.topSuffix, id:\.key) { key, value in
                HStack{
                    Text(key)
                    Spacer()
                    Text("\(value)")
                }
            }
            .listStyle(.plain)
        }
    }
}

enum SelectForPicker : String, Identifiable, CaseIterable{
    case all = "All suffix"
    case top = "Top 3 latter suffix"
    
    var id: SelectForPicker { self }
}
