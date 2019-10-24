class UsuariosController < ApplicationController
  include MyModules::PagamentoCielo
  include MyModules::Util
  
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:destroy, :index]
  before_action :criacao,        only: [:endereco, :editar_assinatura, :detalhar_assinatura,  :aceitar_contrato]
  
  def index
  end
  
  def visualizar_contrato
    @usuario = Usuario.find(params[:id])
  end
  
  def aceitar_contrato
    @usuario = Usuario.find(params[:id])
    if (params[:aceitar] == 'true')
      @usuario.update_attributes(passo_criacao: PASSO_PLANO)
      redirect_to editar_assinatura_usuario_path(@usuario)
    else
       @usuario.destroy
      flash[:success] = t :msg_info_conta_apagada
      redirect_to root_url
    end
  end
  
  def alterar_tipo
    usr = Usuario.find(params[:id])
    
    if usr.tipo_usuario == USUARIO_COMUM
      tipo = USUARIO_MODERADOR
    else
      tipo = USUARIO_COMUM
    end
    
    usr.update_attributes(tipo_usuario: tipo)
    render :index
  end
  
  def reenviar_email_ativacao
    usr = Usuario.find(params[:id])
    usr.create_reset_digest
    usr.activate
    usr.send_password_reset_email
    flash[:success] = t :msg_info_email_enviado
    render :index
  end
    
  def show_modal
    @usuario = Usuario.find(params[:id])
    @plano = @usuario.planos.last
    @modal = params[:acao]
    if @modal == MODAL_USU_PAGTO
      response = consultar_pagamento(ambiente_pagto, @plano)
      
      if CIELO_SUCESSO.include? response.code
        @retorno = JSON.parse(response.body)
        
        # puts 'sucesso'
        # puts @retorno
      end
      
    elsif @modal == MODAL_USU_COORD
      
      puts 'mapou'
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def endereco
    @usuario = Usuario.find(params[:id])
    if @usuario.activated?
      @botao = "label_atualizar"
    else
      @botao = "label_proximo"
    end
  end
  
  def salvar_endereco
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(endereco_parms)
      
      @usuario.update_attributes(lat: dms_to_degrees(@usuario.lat_deg, @usuario.lat_min, @usuario.lat_seg, @usuario.lat_card), 
                                lng: dms_to_degrees(@usuario.lng_deg, @usuario.lng_min, @usuario.lng_seg, @usuario.lng_card))
      if !@usuario.activated?
        @usuario.update_attributes(passo_criacao: PASSO_CONTRATO)
        redirect_to visualizar_contrato_usuario_path(@usuario)
      else
        flash[:success] = t :msg_info_perfil_atualizado
        redirect_to @usuario
      end
    else
      render 'endereco'
    end
  end
  
  def editar_assinatura
    @usuario = Usuario.find(params[:id])
    
    params[:plano] = PLANO_BASICO #@usuario.planos.last.tipo if @usuario.planos.count > 0
    
    @plano = @usuario.planos.last
    
  end
  
  def detalhar_assinatura
    @usuario = Usuario.find(params[:id])
    @plano = @usuario.planos.last
    if flash[:danger].blank?
      flash.now[:danger] = t :msg_info_qtde_pombos_permitido, qtde: QTDE_POMBOS_BASICO if  bloqueio_por_limite_qtde(@usuario, @plano)
    end
  end
  
  def assinar
    @usuario = Usuario.find(params[:id])
    
    if ! @usuario.update_attributes(numero_cartao: params[:numero_cartao], bandeira_cartao: params[:bandeira_cartao], nome_cartao: params[:nome_cartao], dtexpirado: params[:dtexpirado])
      render 'editar_assinatura'
      return
    end
    
    qtde = @usuario.pombos.count
    
    if (params[:plano] == PLANO_BASICO && qtde > QTDE_POMBOS_BASICO)
      flash[:danger] = t :msg_erro_quantidade_incompativel_plano, qtde: qtde
      render :editar_assinatura
      return
    end
    
    @plano = Plano.new
    
    @plano.tipo = params[:plano]
    @plano.moeda = "label_moeda_#{@usuario.lingua}"
    @plano.usuario = @usuario
    
    @plano.save
    
    if @plano.tipo == PLANO_BASICO
      
      @plano.update_columns(dtinicio_pagto: Time.now, valor_mensal: 0)
      
      if !@usuario.activated?
        @usuario.update_attributes(passo_criacao: PASSO_EMAIL)
        @usuario.send_activation_email
        flash[:info] = t (:msg_info_verifique_email)
      
        redirect_to root_url
      else
        redirect_to @usuario
      end
    else
      
    realizar_pagto(@usuario, @plano, params[:cvc_par])
      
    end  
  end
  
  def cancelar_assinatura
    cancelado = false
    @usuario = Usuario.find(params[:id])
    @plano = @usuario.planos.last
    
    if @plano.tipo == PLANO_BASICO
      cancelado = true
    else
      response = cancelar_pagto(ambiente_pagto, @plano.id.to_s, @plano.id_recorrencia_operadora)
      
      if CIELO_SUCESSO.include? response.code
        cancelado = true
      elsif CIELO_ERROS.include? response.code
        cancelado = true
      else
        retorno = JSON.parse(response.body)
        
        msg = response.code + " - " + retorno[0]["Message"]
        flash[:danger] = "#{t :msg_erro_cancelamento_ass }: #{msg}"
        
        redirect_to detalhar_assinatura_usuario_path(@usuario)
      end
    end
    
    if cancelado
      @plano.update_columns(dtcancelamento: Time.now, tipo: PLANO_BASICO)
      flash[:success] = t(:msg_info_assinatura_cancelada)
      redirect_to @usuario
    end
    
  end
  
  def show
    @usuario = Usuario.find(params[:id])
    redirect_to root_url and return unless @usuario.activated?
    #debugger
  end

  def new
    @usuario = Usuario.new
    @usuario.fuso = 'Brasilia'
  end
  
  def create
    @usuario = Usuario.new(user_params)
    @usuario.tipo_usuario = USUARIO_COMUM
    @usuario.passo_criacao = PASSO_ENDERECO
    @usuario.lingua = "pt-BR"
    @usuario.fuso = 'Brasilia' if !@usuario.fuso
    
    if @usuario.save
      redirect_to endereco_usuario_path(@usuario)
    else
      render 'new'
    end
  end
  
  def edit
    @usuario = Usuario.find(params[:id])
  end
  
  def update
    @usuario = Usuario.find(params[:id])
    
    if @usuario.update_attributes(user_params)
      flash[:success] = t :msg_info_perfil_atualizado
      redirect_to @usuario
    else
      render 'edit'
    end
  end
  
  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = t :msg_info_conta_apagada
    redirect_to root_url
  end

  private

    def user_params
      params.require(:usuario).permit(:nome, :email, :password,:password_confirmation, :lingua, :tel1, :tel2, :fuso, :nome_time)
    end
    
    def endereco_parms
      params.require(:usuario).permit(:lat_card, :lat_deg, :lat_min, :lat_seg, :lng_card, :lng_deg, :lng_min, :lng_seg, :logradouro)
    end
    
    def pagto_parms
      params.require(:usuario).permit(:numero_cartao, :bandeira_cartao, :nome_cartao, :dtexpirado)
    end
    
    # Confirms the correct user.
    def correct_user
      @usuario = Usuario.find(params[:id])
      
      return if current_user.admin
      
      if !current_user?(@usuario)
        flash[:danger] = t(:msg_erro_acao_nao_permitida)
        redirect_to usuario_path(current_user)
      end
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def criacao
      usuario = Usuario.find(params[:id])
      return if !usuario.activated?
      
      if !logged_in? 
        flash[:danger] = t(:msg_erro_acao_nao_permitida)
        redirect_to root_url
      else
        correct_user
      end
        
    end
    
    def realizar_pagto(usuario, plano, cvc)
      if (usuario.planos.where("tipo <> ?", PLANO_BASICO).count > 0)
        dtini_pagto = Time.now
      else
        dtini_pagto = 1.month.from_now
      end
      
      plano.valor_mensal = (plano.tipo == PLANO_MASTER ? PRECO_PROMO_MEDIO : PRECO_PROMO_TOP)
      
      response = efetuar_pagto_manual(ambiente_pagto, usuario, plano, cvc, dtini_pagto)
      
      if CIELO_SUCESSO.include? response.code
        retorno = JSON.parse(response.body)
        
        plano.update_columns(id_recorrencia_operadora: retorno["Payment"]["RecurrentPayment"]["RecurrentPaymentId"],
                              url_recorrencia_operadora: retorno["Payment"]["RecurrentPayment"]["Link"]["Href"],
                              dtinicio_pagto: dtini_pagto, valor_mensal: plano.valor_mensal)
                              
        flash[:success] = t :msg_info_assinatura_sucesso
    
        if !usuario.activated?
          usuario.update_attributes(passo_criacao: PASSOS_OK)
          usuario.activate
          log_in usuario
        end
        
        redirect_to usuario
        
      else
        
        if CIELO_ERROS.include? response.code
          msg = response.code 
        else
          retorno = JSON.parse(response.body)
          msg = response.code + " - " + retorno[0]["Message"]
        end
        
        flash[:danger] = "#{t :msg_erro_assinatura }: #{msg}"
        
        redirect_to editar_assinatura_usuario_path(usuario)
      end
      
    end
    

end
