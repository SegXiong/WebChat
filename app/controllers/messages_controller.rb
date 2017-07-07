class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]

    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages

    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.where("conversation_id = ? AND user_id != ?", @conversation, current_user).each do |message|
          message.update(:read => true)
        end

      end
    end
    @message = @conversation.messages.new

  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)

    end

  end

  def destroy
    @message = @conversation.messages.find(params[:id])
    @message.destroy
    redirect_to :back

  end

  private

  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])

  end

  def message_params
    params.require(:message).permit(:content, :user_id)

  end
end
