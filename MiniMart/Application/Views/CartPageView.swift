import SwiftUI

struct CartPageView: View {
    @EnvironmentObject var cartState: CartState
    @State var isOrderConfirmationAlertPresented: Bool = false
    
    var body: some View {
        VStack(){
            List(cartState.cartItems, id:\.product.id) {item in
                    HStack(alignment: .top) {
                        RemoteImage(urlString: item.product.imageUrl)
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(item.product.name)
                            Spacer()
                                .frame(height: 8)
                            Text("\(item.product.price)円")
                            Spacer()
                                .frame(height: 8)
                            Text("\(item.quantity)個")
                            
                        }.padding(.vertical, 8)
                    }
            }
            List{
                Text("合計: \(cartState.totalPrice)円")
            }
            Button(action: {self.isOrderConfirmationAlertPresented = true}){
                Text("注文する")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }.alert(isPresented: $isOrderConfirmationAlertPresented) {
            Alert(
                title: Text("注文が完了しました"),
                message: nil,
                dismissButton: Alert.Button.default(Text("OK")) {
                    cartState.clear()
                }
            )
        }
        .navigationTitle("カート")
    }
}

struct CartPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CartPageView()
        }.environmentObject(CartState())
    }
}
