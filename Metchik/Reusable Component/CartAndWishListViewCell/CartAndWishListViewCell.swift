//
//  CartAndWishListViewCell.swift
//  Metchik
//
//  Created by Hassan on 06/05/2024.
//

import SwiftUI

struct CartAndWishListViewCell: View {
    typealias Colors = Asset.Colors
    @StateObject var viewModel: CartAndWishListViewModelCell
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            
            AsyncImage(url: viewModel.product.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80,height: 80)
                    .cornerRadius(10)
                    .padding(.leading)
            } placeholder: {
                ProgressView()
                    .frame(width: 80,height: 80)
                    .cornerRadius(10)
                    .padding(.leading)
            }
            VStack(alignment: .leading,spacing: 2) {
                Text(viewModel.product.name)
                    .font(.poppins(.semiBold, size: 14))
                
                Text(viewModel.product.shortDescription)
                    .font(.poppins(.regular, size: 11))
                    .foregroundStyle(Colors.secondaryLabelColor.swiftUIColor)
                    .padding(.bottom,12)
                Text("\(String(format: "%.2f", viewModel.product.price)) L.E")
                    .font(.poppins(.bold, size: 14))
                    .padding(.bottom,4)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            VStack {
                HStack {
                    
                    viewModel.cartProduct.color
                        .frame(width: 20, height: 20)
                        .cornerRadius(10)
                    Text(viewModel.cartProduct.size.rawValue)
                        .font(.poppins(.semiBold, size: 14))
                        .foregroundColor(Colors.secondaryButtonColor.swiftUIColor
                        )
                        .frame(width: 30, height: 30)
                        .background(  RoundedRectangle(cornerRadius: 15)
                            .stroke()
                            .foregroundColor(Colors.borderCategoryColor.swiftUIColor))
                }
                VStack {
                    StepperView(
                        maxAvailableProduct: $viewModel.maxAvailableProduct,
                        currentStepperValue: $viewModel.currentStepperValue)
                }
            }
            .padding(.trailing)
            .cornerRadius(13)
        }
        .frame(height: 115)
        .background(.white)
        .cornerRadius(13)
        .padding(1)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: -1, y: -1)
    }
}
struct CartProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        if let cartProductViewModelCell = DependencyManager.shared.sharedContainer
            .resolve(CartAndWishListViewModelCell.self) {
            CartAndWishListViewCell(viewModel: cartProductViewModelCell)
        }
    }
}
