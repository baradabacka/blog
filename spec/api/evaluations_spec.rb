require 'spec_helper'

describe Base::V1::Evaluations do
  let(:user) { create(:user) }
  let(:entry) { create(:entry, user_id: user.id) }

  describe '#create' do
    let(:current_request) { "/api/v1/evaluations?entry_id=#{entry.id}&appraisal=4" }
    context 'current_request' do
      it 'body' do
        post current_request
        expect(response.body).to eq( { data: { average_rating: entry.evaluations.average(:appraisal) } }.to_json )
      end

      it 'response code' do
        post current_request
        expect(response.code).to eq('201')
      end
    end
  end

  context 'bad request' do
    it 'missing params' do
      post '/api/v1/evaluations'
      expect(response.code).to eq('400')
    end

    it 'value is not in range 1..5' do
      post "/api/v1/evaluations?entry_id=#{entry.id}&appraisal=6"
      expect(response.code).to eq('400')
    end
  end
end