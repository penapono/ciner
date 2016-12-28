#
# Módulo para organizar e testar os breadcrumbs dos controllers
# Cada controller deve implementar seu breadcrumb por action em app/breadcrumbs.
# O resultado esperado para o breadcrumb por action deve ser testado
# no controller.
#
# Exemplo de uso: {app,spec}/controllers/operator/report_schedules_controller
#

module BreadcrumbController
  extend ActiveSupport::Concern

  def breadcrumbs
    @breadcrumbs ||= breadcrumbs_for(action_name)
  end

  private

  def breadcrumbs_for(action_name)
    return [] unless has_breadcrumbs?(action_name)

    actions_breadcrumbs[action_name.to_sym].map do |breadcrumb|
      breadcrumb_item(breadcrumb[0], breadcrumb[1])
    end
  end

  def breadcrumb_item(title, url)
    { title: title, url: url}
  end

  def has_breadcrumbs?(action_name)
    ! actions_breadcrumbs[action_name.to_sym].nil?
  end

  #
  # É usado pelos breadcrumbs para garantir que os breadcrumb que precisam de
  # atributos do recurso sejam invocados apenas nas actions corretas.
  # Ex: um breadcrumb de show de Post terá o título como parte final. Como o
  # maps de breadcrumbs/action é carregado todo junto, indenpendente da action,
  # na action index precisamos garantir que o breadcrumb que usa o recurso não
  # seja carregado, pois a action não trata de recurso específico
  #
  def has_resource?
    (action_name == 'show' || action_name == 'edit' || action_name == 'update')
  end
end
