class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
      #indexアクションのindex.html.erbを表示するように指定
      #indexアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻ります
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)

    #privateメソッドとしてmessage_paramsを定義し、
    #メッセージの内容contentをmessagesテーブルへ保存できるようにします。
  end
end
