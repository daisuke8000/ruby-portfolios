require 'trello'
require 'pry'
require 'dotenv'
#rubyだと以下が必要
Dotenv.load

class ScheduleManager
  attr_reader :account, :board_name

  def initialize(account, board_name)
    @account = account
    @board_name = board_name
    Trello.configure do |config|
      config.developer_public_key =ENV['TRELLO_PUBLIC_KEY']
      config.member_token =ENV['TRELLO_MEMBER_TOKEN']
    end
  end

  def puts_card
    #Cardsの表示
    cards = get_cards

    puts '------------------------'
    puts '[My schedule_cards]'
    cards.each do |card|
      puts card.name

    end
    puts '------------------------'
  end

  def get_cards
    member = Trello::Member.find(account)
    # Trelloのボード全取得
    boards = member.boards
    # 一致する名前のボードを取得（inputにしてみると幅が広がりそう）
    board = boards.find { |board| board.name == board_name }
    # ボード内の全リストを取得(配列指定で各リストを取得。今回は[0]を指定)
    list = board.lists[0]
    binding.pry
    # カードの名前を全出力
    cards = list.cards
  end

end

sm = ScheduleManager.new('daisukesasaki19', 'My schedule')
sm.puts_card