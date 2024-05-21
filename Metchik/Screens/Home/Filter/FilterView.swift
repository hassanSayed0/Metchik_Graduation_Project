//
//  FilterView.swift
//  Metchik
//
//  Created by maged on 21/05/2024.
//

import SwiftUI

struct FilterView: View {
    
    let spacingBetweenColumns: CGFloat = 5
    let viewModel: FilterViewModel = FilterViewModel()
    @State private var selectedItem: String = "Dresses"
    
    let dayList: [String] = ["New Today", "New This Week", "Top Sellers"]
    @State var dayListSelected = "New Today"
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            HStack {
                Text("Categories")
                    .font(.poppins(.bold, size: 20))
                Spacer()
            }
            
            
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: spacingBetweenColumns),
                        GridItem(.flexible(), spacing: spacingBetweenColumns),
                        GridItem(.flexible(), spacing: spacingBetweenColumns),
                        GridItem(.flexible(), spacing: spacingBetweenColumns)
                    ],
                    spacing: 20
                ) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryButton(category: category, isSelected: selectedItem == category) {
                            print("\(category) button clicked")
                            selectedItem = category
                        }
                    }
                }
            }
            .frame(height: 140 )
            
            
            // Price Range Section
            HStack {
                Text("Price Range")
                    .font(.poppins(.bold, size: 20))
                Spacer()
            }
            
            
            // Sort by Section
            HStack {
                Text("Sort By")
                    .font(.poppins(.bold, size: 20))
                Spacer()
            }
            
            HStack {
                ForEach(dayList, id: \.self) { day in
                    CategoryButton(category: day, isSelected: dayListSelected == day) {
                        print("\(day) button Clicked")
                        dayListSelected = day
                    }
                }
            }
            
            // Rating Section
            HStack {
                Text("Rating")
                    .font(.poppins(.bold, size: 20))
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
