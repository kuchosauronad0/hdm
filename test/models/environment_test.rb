require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test "list the environments" do
    expected_environments = %w(
      development
      eyaml
      globs
      hdm
      minimal
      multiple_hierarchies
      no_config
      test
      v3
    )
    assert_equal expected_environments, Environment.all_names
  end

  test "create development environment" do
    assert Environment.new(name: 'development')
  end

  test "environments with same name are equal" do
    development_one = Environment.new(name: "development")
    development_two = Environment.new(name: "development")
    assert_equal development_one, development_two
  end

  test "environments with different names are not equal" do
    development_one = Environment.new(name: "development")
    development_two = Environment.new(name: "hdm")
    assert_not_equal development_one, development_two
  end

  test "#to_param returns the name" do
    development = Environment.new(name: "development")
    assert_equal "development", development.to_param
  end

  test "#to_s returns the name" do
    development = Environment.new(name: "development")
    assert_equal "development", development.to_s
  end

  test "#hierarchies loads all hierarchies" do
    environment = Environment.new(name: "development")
    hierarchies = [Hierarchy.new(environment: environment, name: "test", backend: :yaml)]
    Hierarchy.stub(:all, hierarchies) do
      assert_equal hierarchies, environment.hierarchies
    end
  end
end
