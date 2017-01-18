namespace :development_seed do

  desc 'Creates movies, series, critics, broadcasts'

  task create_or_update: :environment do
    # ------------------------------ Funções no Set ----------------------------

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
        SetFunction.find_or_create_by(name: name, description: name)
    end

    # -------------------------------- Filmes ---------------------------------

    Movie.all.destroy_all

    Movie.find_or_create_by(
      original_title: "Inception",
      title: 'A Origem',
      year: 2010,
      length: 148,
      release: DateTime.parse("06/08/2010"),
      brazilian_release: DateTime.parse("06/08/2010"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/movies/inception.jpg'))
    )

    Movie.find_or_create_by(
      original_title: "Moulin Rouge!",
      title: 'Moulin Rouge! Amor em vermelho',
      year: 2001,
      length: 127,
      release: DateTime.parse("01/06/2001"),
      brazilian_release: DateTime.parse("24/08/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/movies/moulin_rouge.jpg'))
    )

      Movie.find_or_create_by(
      original_title: "Once",
      title: 'Apenas uma vez',
      year: 2007,
      length: 85,
      release: DateTime.parse("15/06/2007"),
      brazilian_release: DateTime.parse("15/06/2007"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/movies/once.jpg'))
    )

      Movie.find_or_create_by(
      original_title: "Donnie Darko",
      title: 'Donnie Darko',
      year: 2001,
      length: 104,
      release: DateTime.parse("26/10/2001"),
      brazilian_release: DateTime.parse("26/10/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/movies/donnie.jpg'))
    )

    # -------------------------------- Séries ---------------------------------

    Serie.all.destroy_all

    Serie.find_or_create_by(
      original_title: "Skins",
      title: 'Skins',
      year: 2007,
      length: 45,
      release: DateTime.parse("02/10/2007"),
      brazilian_release: DateTime.parse("02/10/2007"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/series/skins.jpg'))
    )

    Serie.find_or_create_by(
      original_title: "How I Met Your Mother",
      title: 'Como Eu Conheci Sua Mãe',
      year: 2005,
      length: 25,
      release: DateTime.parse("19/09/2005"),
      brazilian_release: DateTime.parse("19/09/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/series/himym.jpg'))
    )

    Serie.find_or_create_by(
      original_title: "Shameless",
      title: 'Shameless',
      year: 2011,
      length: 46,
      release: DateTime.parse("09/01/2011"),
      brazilian_release: DateTime.parse("09/01/2011"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/series/shameless.jpg'))
    )

    Serie.find_or_create_by(
      original_title: "Doctor Who",
      title: 'Doctor Who',
      year: 2005,
      length: 45,
      release: DateTime.parse("26/03/2005"),
      brazilian_release: DateTime.parse("26/03/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      cover: open(File.join(Rails.root, 'app/assets/images/seed/series/doctor.jpg'))
    )

    # -------------------------------- Críticas --------------------------------

    Critic.all.destroy_all

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Doctor Who').id,
      filmable_type: Serie,
      name: "Doctor Who: Viajando no Espaço-Tempo",
      content: "O que dizer sobre a maior serie de ficção cientifica? Fantástica,incrível,surpreendente,brilhante tudo isso é pouco para descrever Doctor who,com uma grande mistura de comedia e ficção cientifica doctor who surpreende com elenco fantástico e historia cativante,mesmo tendo um inicio meio fraco principalmente em relação a efeitos especiais,com o tempo você acaba se apaixonando pelo Doctor e suas companions e sofre com as despedidas,recomendo bastante. "
    )
  end
end
