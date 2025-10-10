require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get "/dashboard"

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      upcoming_trimester = Trimester.create!(
        term: 'Upcoming',
        year: (Date.current.year + 1).to_s,
        start_date: Date.current + 3.months,
        end_date:   Date.current + 6.months,
        application_deadline: Date.current + 1.month
      )

      far_trimester = Trimester.create!(
        term: 'Far',
        year: (Date.current.year + 2).to_s,
        start_date: Date.current + 9.months,
        end_date:   Date.current + 12.months,
        application_deadline: Date.current + 8.months
      )

      get "/dashboard"

      expect(response.body).to include("#{upcoming_trimester.term} - #{upcoming_trimester.year}")
      expect(response.body).not_to include(far_trimester.term)
    end

    it 'displays links to the courses in the upcoming trimester' do
    end
  end
end