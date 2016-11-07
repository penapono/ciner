namespace :set_functions do
  desc 'Adicionando funções no set'

  task :create_or_update => :environment do
    names = [
      "Produção", "Produção de Set", "Produção Executiva",
      "Direção", "Roteiro", "Direção de Fotografia", "Sound Designer",
      "Elenco", "Direção de Arte", "Edição", "Efeitos Visuais",
      "Assistente de Direção", "Câmera", "Casting", "Trilha Sonora",
      "Trilha Sonora Original", "História", "Figurino", "Continuidade",
      "Assistente de Fotografia", "Assistente de Som", "Captação de Som",
      "Edição de Som", "Colorização/Finalização", "Maquiagem", "Still",
      "Making Of", "Dublê", "Foley", "Figuração", "Contrarregra",
      "Narração", "Dublagem", "Agradecimentos"
    ]

    names.each do |name|
      set_function =
        SetFunction.find_or_initialize_by(name: name, description: name)
      set_function.save
    end
  end
end


