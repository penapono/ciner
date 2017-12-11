# frozen_string_literal: true

class Notification < ActiveRecord::Base
  # Validations
  validates :receiver_id,
            presence: true

  # Enums
  enum status: { pending: 0, read: 1 }
  enum answer: { no_answer: 0, waiting: 1, approved: 2, declined: 3 }
  enum notification_type: {
    friend_request: 0,
    accept_friend_request: 1,
    decline_friend_request: 2,
    delate_ok: 3,
    trophy: 4
  }

  def self.for_user(user)
    Notification.where(receiver_id: user.id, answer: [0, 1]).order(status: :asc)
  end

  def sender
    User.find(sender_id)
  rescue
    :system
  end

  def from_ciner?
    sender == :system
  end

  def receiver
    User.find(receiver_id)
  end

  def sender_avatar
    return "default/user/image.png" if sender == :system
    sender.avatar
  end

  def created_at_str
    (I18n.l created_at, format: :short)
  end
end

# 1.2. Quando alguém aceita a solicitação de amizade, o usuário que enviou o pedido recebe a informação que tal pessoa aceitou o pedido de amizade.

# Mensagem:
# NOME DE USUÁRIO aceitou seu pedido de amizade.

# NOME DE USUÁRIO é um link para o Perfil do usuário que aceitou o pedido de amizade.

# 2. Indicações entre usuários:
# 2.1 Quando alguém indica filme/série.

# Mensagem:
# NOME DE USUÁRIO te indicou NOME DO FILME.
# NOME DE USUÁRIO te indicou NOME DA SÉRIE.

# NOME DE USUÁRIO é um link para o perfil de quem indicou.
# NOME DO FILME é um link pra o filme.
# NOME DA SÉRIE é um link para a série.

# 2.2 Quando alguém indica um Ciner Vídeo.

# Mensagem:
# NOME DE USUÁRIO te indicou o Ciner Vídeo TÍTULO DO CINER VÍDEO.

# NOME DE USUÁRIO é um link para o perfil de quem indicou e NOME DO CINER. TÍTULO DO CINER VÍDEO é um link pra o Ciner Vídeo.

# 3. Críticas:
# 3.1 Quando alguém curte uma crítica.

# Mensagem:
# Sua crítica em NOME DO FILME foi curtida.
# Sua crítica em NOME DA SÉRIE foi curtida.

# NOME DO FILME é um link pra o filme.
# NOME DA SÉRIE é um link para a série.

# 4. Lembrete de Evento da Agenda do Cinema:
# 4.1 Quando o usuário pediu para ser lembrado de um evento.
# Serão 3 notificações: faltando 15 dias, faltando 1 semana e faltando 1 dia.

# Mensagem:
# O evento NOME DO EVENTO será realizado daqui 15 dias.
# O evento NOME DO EVENTO será realizado daqui 1 semana.
# O evento NOME DO EVENTO será realizado amanhã!

# NOME DO EVENTO é um link para o evento.

# 5. Empréstimo da Coleção:
# 5.1 Quando um filme/série da coleção está emprestado:
# Notificar a cada mês.

# Mensagem:
# NOME DO FILME está emprestado para NOME há 1 mês (2 meses, 3 meses...).
# NOME DA SÉRIE está emprestado para NOME há 1 mês (2 meses, 3 meses...).

# NOME DO FILME é um link pra o filme.
# NOME DA SÉRIE é um link para a série.
# NOME é o nome que usuário escreveu quando anotou na coleção. Não será link.
