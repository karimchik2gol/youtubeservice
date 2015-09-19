require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post :create, offer: { application_deadline: @offer.application_deadline, description: @offer.description, location_dependent: @offer.location_dependent, location_dependent_boolean: @offer.location_dependent_boolean, name: @offer.name, project_type: @offer.project_type, subscriber_range: @offer.subscriber_range, targe_audience_geos: @offer.targe_audience_geos, target_channel_categories: @offer.target_channel_categories }
    end

    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should show offer" do
    get :show, id: @offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer
    assert_response :success
  end

  test "should update offer" do
    put :update, id: @offer, offer: { application_deadline: @offer.application_deadline, description: @offer.description, location_dependent: @offer.location_dependent, location_dependent_boolean: @offer.location_dependent_boolean, name: @offer.name, project_type: @offer.project_type, subscriber_range: @offer.subscriber_range, targe_audience_geos: @offer.targe_audience_geos, target_channel_categories: @offer.target_channel_categories }
    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete :destroy, id: @offer
    end

    assert_redirected_to offers_path
  end
end
