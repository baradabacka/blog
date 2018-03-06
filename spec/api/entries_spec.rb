require 'spec_helper'

describe Base::V1::Entries do
  let(:user) { create(:user) }
  let(:entry) { create(:entry, user_id: user.id) }

  describe '#top' do
    context 'current request' do
      it 'body' do
        count = 1
        get "/api/v1/entries/top?count=#{count}"
        result = Entry.order(rating: :desc).select(:id, :caption, :content).first(count)
        expect(response.body).to eq({data: result}.to_json)
      end

      it 'response code' do
        get '/api/v1/entries/top?count=1'
        expect(response.code).to eq('200')
      end
    end

    context 'bad request' do
      it 'with out params' do
        get '/api/v1/entries/top'
        expect(response.code).to eq('400')
      end

      it 'bad params' do
        get '/api/v1/entries/top?count=asd'
        expect(response.code).to eq('400')
      end
    end
  end

  describe '#autor_ip' do
    context 'current request' do
      it 'body' do
        get '/api/v1/entries/autor_ip'
        sql = 'SELECT DISTINCT entries.user_id, entries.autor_ip, users.login' \
             ' FROM entries INNER JOIN users ON users.id = entries.user_id' \
             ' WHERE autor_ip IN (SELECT entries.autor_ip FROM entries' \
             ' GROUP BY entries.autor_ip HAVING count(user_id)>1)'
        result = Entry.find_by_sql(sql).group_by(&:autor_ip)
                      .each_with_object({}) { |array, result| result[array[0]] = array[1].pluck(:login) }
        expect(response.body).to eq({data: result}.to_json)
      end

      it 'response code' do
        get '/api/v1/entries/autor_ip'
        expect(response.code).to eq('200')
      end
    end
  end

  describe '#create_post' do
    let(:current_request) { "/api/v1/entries?autor_ip=123&login=test&caption=test&content=test" }

    context 'current_request' do
      it 'change count entries' do
        expect { post current_request }.to change{ Entry.count }.by(1)
      end

      it 'change count user' do
        User.where(login: 'test').destroy_all
        expect { post current_request }.to change{ User.count }.by(1)
      end

      it 'response code' do
        post current_request
        expect(response.code).to eq('201')
      end
    end

    context 'bad request' do
      it 'not available any params' do
        post "/api/v1/entries"
        expect(response.code).to eq('400')
      end
    end
  end
end