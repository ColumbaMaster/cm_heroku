class MensagensController < ApplicationController
  def new
    @mensagem = Mensagem.new
  end
  
  def create
    @message = Mensagem.new message_params

    if @message.valid?
      MessageMailer.contact_me(@message).deliver_now
      flash[:success] = t :msg_info_email_enviado_contato
      redirect_to faleconosco_path
    else
      flash[:danger] = t :msg_erro_email_nao_enviado
      redirect_to faleconosco_path
    end
  end
  
  private

    def message_params
      params.require(:mensagem).permit(:nome, :email, :body, :telefone)
    end
  
end
