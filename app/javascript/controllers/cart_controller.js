import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static values = { url: String };
  connect() {
    this.loadCart();
  }
  async loadCart() {
    const response = await fetch(this.urlValue);
    const cartItems = await response.json();

    if (cartItems.length === 0 ) {
      this.element.innerHTML = "<p>Your cart is empty.</p>";
    } else {
      this.element.innerHTML = `
        <ul>
          ${cartItems
            .map(
              (item) => `
                <li>
                  ${item.product.name} - ${item.quantity} x ${item.product.price}
                  <button data-action="click->cart#removeItem" data-cart-item-id="${item.id}">Remove</button>
                </li>
                `
            )
            .join("")}
            </ul>
            <button data-action="click->cart#checkout">Checkout</button>
      `;
    }
  }

  async addItem(event) {
    const productId = event.target.dataset.productId;

    const response = await fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json", 
      },
      body: JSON.stringify({ cart_item: { product_id: productId, quantity: 1 } }),
    });
    if (response.ok) {
      this.loadCart();
    }
  }

  async removeItem(event) {
    const cartItemId = event.target.dataset.cartItemId;

    const response = await fetch(`${this.urlValue}/${cartItemId}`, {
      method: "DELETE",
    });

    if (response.ok ) {
      this.loadCart();
    }
  }

  async checkout() {
    const response = await fetch(`${this.urlValue}/checkout`, {
      method: "POST",
    });

    if (response.ok) {
      alert("Checkout successful!");
      this.loadCart();
    }
  }
}
