# frozen_string_literal: true

require 'test_helper'

class SuggestionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get suggestions_new_url
    assert_response :success
  end

  test 'should get create' do
    get suggestions_create_url
    assert_response :success
  end

  test 'should get show' do
    get suggestions_show_url
    assert_response :success
  end
end
