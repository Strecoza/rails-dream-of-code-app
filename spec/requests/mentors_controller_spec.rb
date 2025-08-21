require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context "When mentors exist" do
        before do
            Mentor.create!(first_name: "Anna", last_name: "Klein", email: "aKlein@test.com", max_concurrent_students: 3) 
            Mentor.create!(first_name: "Tom",   last_name: "Cruz",  email: "tCruz@test.com",   max_concurrent_students: 5) 
        end

      it "renders page listing mentors" do
        get "/mentors"
        expect(response.body).to include("Mentors")
        expect(response.body).to include("First name:", "Anna")
        expect(response.body).to include("Last name:", "Klein")
        expect(response.body).to include("First name:", "Tom")
        expect(response.body).to include("Last name:", "Cruz")
        end
      end

      context "When mentors no exist" do
        before { Mentor.delete_all }

      it "returns title without mentors list" do
        get "/mentors"
        expect(response.body).to include("Mentors")
        expect(response.body).not_to include("First name:")
        expect(response.body).not_to include("Last name:")
        expect(response.body).not_to include("Show this mentor")
        end
    end
end

describe "GET /mentors/:id" do
    context "When mentor exists" do
        let!(:mentor) { Mentor.create!(first_name: "John", last_name: "Doe", email: "jDoe@test.com", max_concurrent_students: 3) }

      it "renders page show mentor" do
        get "/mentors/#{mentor.id}"
         expect(response.body).to include("First name:", "John")
        expect(response.body).to include("Last name:", "Doe")
        expect(response.body).to include("jDoe@test.com")
        end
      end
    end
end