import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products"
export default class extends Controller {
  static values = { url: String };
  connect() {
    this.loadProducts();
  }

  async loadProducts(){
    const response = await fetch(this.urlValue);
    const products = await response.json();

    this.element.innerHTML = products
      .map(
        (product) => `
          <div class="product-card">
            <h3>${product.name}</h3>
            <p>${product.price}</p>
            <button data-action="click->cart#addItem" data-product-id="${product.id}">Add to Cart</button>
          </div>
          `
      )
      .join("");
  }
}
