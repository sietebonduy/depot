require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get carts_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_url
    assert_response :success
  end

  test "should create cart" do
    assert_difference("Cart.count") do
      post carts_url, params: { cart: {  } }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test "should show cart" do
    get cart_url(@cart)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test "should update cart" do
    patch cart_url(@cart), params: { cart: {  } }
    assert_redirected_to cart_url(@cart)
  end

  test "should destroy cart" do
    post line_items_url, params: { product_id: products(:ruby).id }

    unless session[:cart_id].nil?
      @cart = Cart.find(session[:cart_id])

      assert_difference("Cart.count", -1) do
        delete cart_url(@cart)
      end

      assert_redirected_to store_index_url
    end
  end

  test "adding two unique products to card" do
    cart = Cart.new

    cart.add_product(products(:ruby))
    cart.add_product(products(:rails))

    assert_equal 2, cart.line_items.size
    assert_equal products(:ruby).price + products(:rails).price, cart.total_price
  end

  test "adding two duplicate products to card" do
    cart = Cart.new

    cart.add_product(products(:ruby))
    cart.add_product(products(:ruby))

    assert_equal 1, cart.line_items.size
    assert_equal products(:ruby).price * 2, cart.total_price
  end
end
