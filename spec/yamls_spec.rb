# frozen_string_literal: true

RSpec.describe Yamls do
  let(:params) { nil }

  context "when 1st level nested params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        required: :person,
        nested: %i[person],
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          person: {
            name: "Francesco",
            age: 22,
            role: "admin"
          }
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "age" => 22,
          "role" => "admin"
        }
      )
    end
  end

  context "when 3rd level nested params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        required: :person,
        nested: %i[nested example person],
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          person: {
            name: "Francesco",
            age: 22,
            role: "admin"
          }
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "age" => 22,
          "role" => "admin"
        }
      )
    end
  end

  context "when 2rd level nested request params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        required: :nested,
        nested: %i[nested],
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          nested: {
            example: {
              person: {
                name: "Francesco",
                age: 22,
                role: "admin"
              }
            }
          }
        }
      )
    end

    it "is nested permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "example" => {
            "person" => {
              "name" => "Francesco",
              "age" => 22,
              "role" => "admin"
            }
          }
        }
      )
    end
  end

  context "when multi level nested request params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        required: :book,
        nested:   %i[main nested1 nested2 nested3],
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          book: {
            name: "Francesco",
            label: "test-label",
            values: {
              a_site: 1000,
              b_site: 2000,
              c_site: 3000
            }
          }
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "label" => "test-label",
          "values" => {
            "a_site" => 1000,
            "b_site" => 2000,
            "c_site" => 3000
          }
        }
      )
    end
  end

  context "when model & action params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        model: :model,
        action: :action,
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          model: {
            name: "Francesco",
            age: 22,
            role: "admin"
          }
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "age" => 22,
          "role" => "admin"
        }
      )
    end
  end

  context "when non nested params" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        nested: %i[person],
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          name: "Francesco",
          age: 22,
          role: "admin"
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "age" => 22,
          "role" => "admin"
        }
      )
    end
  end

  context "when non nested params - required: nil" do
    let(:lib) do
      Yamls::Parameters.new(
        params,
        model: :person,
        required: nil,
        filepath: "#{Dir.pwd}/spec/column.yml"
      )
    end

    let(:params) do
      ActionController::Parameters.new(
        {
          name: "Francesco",
          age: 22,
          role: "admin"
        }
      )
    end

    it "is permit parameters" do
      expect(lib.permit.to_h).to eq(
        {
          "name" => "Francesco",
          "age" => 22,
          "role" => "admin"
        }
      )
    end
  end
end
