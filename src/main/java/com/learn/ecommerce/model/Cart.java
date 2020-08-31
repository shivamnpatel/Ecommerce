package com.learn.ecommerce.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Cart {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int itemId;
	private String itemName;
	private int itemPrice;
	private int itemQuantity;
	private int itemDiscount;
	private int totalPrice;
	private int finalPrice;
	@ManyToOne
	@JoinColumn(name = "orderId")
	private Order orders;

	public Cart() {

	}

	public Cart(int itemId, String itemName, int itemPrice, int itemQuantity, int itemDiscount, int totalPrice,
			int finalPrice) {

		this.itemId = itemId;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.itemQuantity = itemQuantity;
		this.itemDiscount = itemDiscount;
		this.totalPrice = totalPrice;
		this.finalPrice = finalPrice;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public int getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(int itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public int getItemDiscount() {
		return itemDiscount;
	}

	public void setItemDiscount(int itemDiscount) {
		this.itemDiscount = itemDiscount;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}

	public Order getOrders() {
		return orders;
	}

	public void setOrders(Order orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "Cart [itemId=" + itemId + ", itemName=" + itemName + ", itemPrice=" + itemPrice + ", itemQuantity="
				+ itemQuantity + ", itemDiscount=" + itemDiscount + ", totalPrice=" + totalPrice + ", finalPrice="
				+ finalPrice + ", orders=" + orders + "]";
	}

	public int getItemPriceAfterDiscount() {

		int disc = (int) ((this.itemDiscount / 100.0) * this.itemPrice);

		return this.itemPrice - disc;
	}

}
