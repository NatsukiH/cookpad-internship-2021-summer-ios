import SwiftUI

struct ProductDetailPageView: View {
    @EnvironmentObject var cartState: CartState
    @State var isCartViewPresented: Bool = false
    
    var product: FetchProductsQuery.Data.Product
    var body: some View {
        
        GeometryReader { bodyView in
            ScrollView {
                VStack(alignment: .leading) {
                    RemoteImage(urlString: product.imageUrl)
                        .frame(width: bodyView.size.width, height: 300)
                    Text(product.name)
                        .frame(height: 20)
                    Text("\(product.price)円")
                        .frame(height: 40)
                    Text(product.summary)
//                        .frame(height: 50)
                    Button(action: { cartState.add(product: product)}){
                        Text("カートに追加")
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                            
                    }
                    .frame(width: bodyView.size.width, height: 50, alignment: .center)
                }.padding(.vertical, 8)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                        self.isCartViewPresented = true
                }){
                    VStack(){
                        Image(systemName: "folder")
                        Text("\(cartState.totalProductCounts)")
                    }
                }
            }
        }
        .sheet(isPresented: $isCartViewPresented) {
            NavigationView {
                CartPageView()
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                    id: UUID().uuidString,
                    name: "商品 \(1)",
                    price: 100,
                    summary: "おいしい食材 \(1)",
                    imageUrl: "https://image.mini-mart.com/dummy/1"
                )
            )
        }
    }
}
