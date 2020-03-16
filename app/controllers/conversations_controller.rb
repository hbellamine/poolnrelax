class ConversationsController < ApplicationController

  def new
    @recipients = User.all - [current_user]
  end

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end

  def index
  @conversation = current_user.mailbox.conversations
  @recipients = User.all - [current_user]

  authorize @conversation
  end

   def show
  @conversation = current_user.mailbox.conversations.find(params[:id])
  end
end

