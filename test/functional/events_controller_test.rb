require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { activity_since: @event.activity_since, activity_type: @event.activity_type, body_part: @event.body_part, description: @event.description, drugs: @event.drugs, entered_at: @event.entered_at, event_type: @event.event_type, level: @event.level, quantity: @event.quantity, temperature: @event.temperature }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { activity_since: @event.activity_since, activity_type: @event.activity_type, body_part: @event.body_part, description: @event.description, drugs: @event.drugs, entered_at: @event.entered_at, event_type: @event.event_type, level: @event.level, quantity: @event.quantity, temperature: @event.temperature }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
