require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters/:id/edit" do
    it "shows application deadline field" do
      t = Trimester.create!(term: "Fall", year: "2025", start_date: Date.today, end_date: Date.today+3.months, application_deadline: Date.today+1.month)
      get edit_trimester_path(t)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("application_deadline") 
    end
  end

  describe "PUT /trimesters/:id" do
    it "updates deadline when valid" do
      t = Trimester.create!(term: "Fall", year: "2025", start_date: Date.today, end_date: Date.today+3.months, application_deadline: Date.today+1.month)
      new_deadline = (Date.today+2.months).to_s
      put trimester_path(t), params: { trimester: { application_deadline: (Date.today+2.months).to_s } }
      expect(response).to have_http_status(:found).or have_http_status(:see_other).or have_http_status(:ok)
      t.reload
      expect(t.application_deadline).to eq(Date.parse(new_deadline))
    end

    it "returns 400 when deadline missing" do
      t = Trimester.create!(term: "Fall", year: "2025", start_date: Date.today, end_date: Date.today+3.months, application_deadline: Date.today+1.month)
      put trimester_path(t), params: { trimester: { application_deadline: "" } }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 400 when invalid date" do
      t = Trimester.create!(term: "Fall", year: "2025", start_date: Date.today, end_date: Date.today+3.months, application_deadline: Date.today+1.month)
      put trimester_path(t), params: { trimester: { application_deadline: "INVALID" } }
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 404 when trimester not found" do
      put trimester_path(id: 99999), params: { trimester: { application_deadline: Date.today.to_s } }
      expect(response).to have_http_status(:not_found)
    end
  end
end