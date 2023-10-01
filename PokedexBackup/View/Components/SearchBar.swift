//
//  SearchBar.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 01/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isFocused: Bool
    
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Buscar", text: $searchText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(12)
            .onTapGesture {
                isFocused = true
                print(isFocused)
            }
            
            if isFocused {
                Button {
                    isFocused = false
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

#Preview {
    SearchBar(searchText: .constant("a"), isFocused: .constant(false))
}
