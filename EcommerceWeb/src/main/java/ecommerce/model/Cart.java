package ecommerce.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void addItem(CartItem item) {
        for (CartItem ci : items) {
            if (ci.getProductId() == item.getProductId()) {
                ci.setQuantity(ci.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public void updateItemQuantity(int productId, int quantity) {
        for (CartItem ci : items) {
            if (ci.getProductId() == productId) {
                ci.setQuantity(quantity);
                return;
            }
        }
    }

    public void removeItem(int productId) {
        Iterator<CartItem> iterator = items.iterator();
        while (iterator.hasNext()) {
            CartItem ci = iterator.next();
            if (ci.getProductId() == productId) {
                iterator.remove();
                return;
            }
        }
    }

    public double getTotalPrice() {
        double total = 0.0;
        for (CartItem ci : items) {
            total += ci.getTotalPrice();
        }
        return total;
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem ci : items) {
            total += ci.getQuantity();
        }
        return total;
    }

    public void clear() {
        items.clear();
    }
} 