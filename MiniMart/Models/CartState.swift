//ガッツリ模範解答を読み込んで参考にしました

import Foundation
import Combine

final class CartState: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func add(product: FetchProductsQuery.Data.Product) {
            if let itemIndex = cartItems.firstIndex(where: { $0.product.id == product.id }) {
                var item = cartItems[itemIndex]
                item.quantity += 1
                cartItems[itemIndex] = item
            } else {
                cartItems.append(.init(product: product, quantity: 1))
            }
        }
    // カートの初期化
    func clear() {
        cartItems = []
    }

    // 合計金額を返すcomputed property
    var totalPrice: Int {
        cartItems.reduce(0) { sum, item in
            // CartItemには product.price * quantityとして定義してある
            sum + item.price
        }
    }
    
    var totalProductCounts: Int {
        cartItems.reduce(0) { sum, item in
            sum + item.quantity
        }
    }

}
