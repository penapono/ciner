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

    object = Movie.find_or_create_by(
      original_title: "Inception",
      title: 'A Origem',
      year: 2010,
      length: 148,
      release: DateTime.parse("06/08/2010"),
      brazilian_release: DateTime.parse("06/08/2010"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/movies/inception.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Moulin Rouge!",
      title: 'Moulin Rouge! Amor em vermelho',
      year: 2001,
      length: 127,
      release: DateTime.parse("01/06/2001"),
      brazilian_release: DateTime.parse("24/08/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/movies/moulin_rouge.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Once",
      title: 'Apenas uma vez',
      year: 2007,
      length: 85,
      release: DateTime.parse("15/06/2007"),
      brazilian_release: DateTime.parse("15/06/2007"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/movies/once.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Donnie Darko",
      title: 'Donnie Darko',
      year: 2001,
      length: 104,
      release: DateTime.parse("26/10/2001"),
      brazilian_release: DateTime.parse("26/10/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

      object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/movies/donnie.jpg'))
      object.save

    # -------------------------------- Séries ---------------------------------

    Serie.all.destroy_all

    object = Serie.find_or_create_by(
      original_title: "Skins",
      title: 'Skins',
      year: 2007,
      length: 45,
      release: DateTime.parse("02/10/2007"),
      brazilian_release: DateTime.parse("02/10/2007"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/series/skins.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "How I Met Your Mother",
      title: 'Como Eu Conheci Sua Mãe',
      year: 2005,
      length: 25,
      release: DateTime.parse("19/09/2005"),
      brazilian_release: DateTime.parse("19/09/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/series/himym.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "Shameless",
      title: 'Shameless',
      year: 2011,
      length: 46,
      release: DateTime.parse("09/01/2011"),
      brazilian_release: DateTime.parse("09/01/2011"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/series/shameless.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "Doctor Who",
      title: 'Doctor Who',
      year: 2005,
      length: 45,
      release: DateTime.parse("26/03/2005"),
      brazilian_release: DateTime.parse("26/03/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last
    )

    object.cover = File.open(File.join(Rails.root, 'app/assets/images/seed/series/doctor.jpg'))
    object.save

    # -------------------------------- Críticas --------------------------------

    Critic.all.destroy_all

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Doctor Who').id,
      filmable_type: Serie,
      content:
        "O que dizer sobre a maior serie de ficção cientifica? Fantástica, " +
        "incrível,surpreendente,brilhante tudo isso é pouco para descrever " +
        "Doctor Who,com uma grande mistura de comedia e ficção cientifica " +
        "doctor Who surpreende com elenco fantástico e historia cativante, " +
        "mesmo tendo um inicio meio fraco principalmente em relação " +
        "a efeitos especiais,com o tempo você acaba se apaixonando pelo " +
        "Doctor e suas companions e sofre com as despedidas,recomendo bastante.",
      rating: 5.0
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Skins').id,
      filmable_type: Serie,
      content:
        "A Série retrata sobre adolescentes que vivem suas vidas loucas e baladeiras, Skins deveria ser uma série simples, mas não foi, com um roteiro incrível, a série retrata a realidade dos adolescentes de hoje em dia, a cada geração, mais a série fica incrível com emoções e despedida de queridos personagens. Skins é uma das melhores séries da atualidade mesmo tendo seu fim em 2013.",
      rating: 4.0
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Shameless').id,
      filmable_type: Serie,
      content:
        "Tá afim de se divertir ? Gosta de ser surpreendido ? Quer curtir um bom seriado ? Pronto! Shameless é a solução, mostrando a risca, o cotidiano de uma família americana, tendo o rei dos alcoólatras como pai, uma irmã mais velha um tanto quanto atraída por fazer escolhas erradas. Não fique ai parado, entre já para essa família.",
      rating: 2.5
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Como Eu Conheci Sua Mãe').id,
      filmable_type: Serie,
      content:
        "How i met your mother é uma série simplesmente fantástica que te prende do início ao fim. A história é sobre Ted (Josh Radnor) contando aos seus dois filhos como conheceu a mãe deles. HIMYM é uma história muito bem contada e com excelentes atores. A série é cheia de mistérios e imprevistos para o telespectador, o que torna ela muito mais viciante a cada temporada. Os atores se encaixam muito bem em seus personagens, ao passar do tempo você vê o amadurecimento deles e se identifica. Além desses elementos, a How i met é bem engraçada e traz uma comedia típica de sitcom e episódios com elementos marcantes. Sem dúvida, HIMYM é excelente e obrigatória para amantes do gênero.",
      rating: 5.5
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Movie.find_by(title: 'A Origem').id,
      filmable_type: Movie,
      content:
        "A Origem (Inception, 2010) não é nenhuma esfinge. Na verdade, a sua " +
        "estrutura, emprestada dos filmes-de-assalto, é bem trivial. " +
        "Acompanhamos o planejamento de um golpe enquanto se aprende o " +
        "essencial de cada personagem. Na hora de pôr o golpe em prática, " +
        "termina o ensaio, começam os imprevistos. " +
        "Grupos de golpistas costumam ter um novato porque é preciso expor " +
        "ao espectador as regras do jogo (que os personagens veteranos, " +
        "obviamente, já conhecem). Em A Origem, a estudante Ariadne " +
        "(Ellen Page) faz essa função. Ela é a nossa representante na " +
        "trama, intrigada com a tal máquina de invadir sonhos inventada " +
        "pelo roteirista e diretor Christopher Nolan. Ironicamente, o " +
        "totem de Ariadne é um peão de xadrez - ela só serve para ser " +
        "a intermediária, a intérprete.",
      rating: 5.0
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Movie.find_by(title: 'Apenas uma vez').id,
      filmable_type: Movie,
      content:
        "Apenas Uma Vez conta a estória de um cantor que faz apresentações " +
        "nas ruas de Dublin, e durante à noite canta suas próprias " +
        "canções. Conhece uma jovem mãe tcheca que tenta se adaptar a " +
        "cidade e as mudanças. Através da música eles se afinam e " +
        "encontram nessa relação força para buscarem uma nova chance. " +
        "Um filme que mostra que uma simples amizade nasce ao acaso, mas " +
        "não por acaso permanece. A música e a afinidade os encorajam " +
        "a tentarem mais uma vez! Vale apena! A trilha sonora é tão " +
        "singela quanto o filme - The Swell Season. Você vai gostar!",
      rating: 1.5
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Movie.find_by(title: 'Donnie Darko').id,
      filmable_type: Movie,
      content:
        "Donnie Darko é fantástico, com uma ótima direção, tu percebe o " +
        "cuidado que o Richard Kelly teve até nos figurantes de cena, " +
        "ótimas atuações, uma fotografia que de coloca totalmente nos " +
        "anos 80, trilha sonora fantástica, muitas vezes fazendo um  " +
        "contraponto entre a descontração e a tensão, um filme que de " +
        "faz ter uma imersão completa dentro dele, alguns probleminhas " +
        "ficam realmente no roteiro, o filme se contradiz e as vezes " +
        "nem ele sabe se explicar, Donnie Darko é um filme complexo " +
        "até demais, lembra muito as obras de David Lynch, mas no final " +
        "vale a pena, pois mistura religião com física, metafísica, " +
        "viagem no tempo..., é loucura, mas que por incrível que pareça, " +
        "o filme tem um sentido. Richard Kelly, a onde foi " +
        "parar todo esse talento?",
      rating: 3.5
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Movie.find_by(title: 'Moulin Rouge! Amor em vermelho').id,
      filmable_type: Movie,
      content:
        "Moulin Rouge chama a atenção logo no inicio, com a fotografia exuberante e repleta de cores, luzes e coreografias muito bem ensaiadas. Começa em um tom de comédia, com efeitos grotescos que contrastam com as seguintes cenas de drama. Ainda que as músicas escolhidas sejam sucessos dos anos 90 e em tese não deveriam combinar em nada com o filme, elas se encaixam e harmonizam perfeitamente com o roteiro. As atuações são ótimas e a performance de Kidman é admirável, ( não é à toa que consideram essa a melhor atuação de sua carreira) seus trajes são impecáveis, sua voz é melodiosa e a atuação não menos incrível (imagino que sejam poucas as atrizes que consigam cantar, dançar e dramatizar dentro de um espartilhos, sobre saltos altos enquanto estão dependuradas à 60 pés de altura)! Ainda que, Christian te alerte sobre o final da história durante todo o desenrolar da trama, ele não deixa de comover.E eu poderia continuar enumerando mais e mais coisas que tornam esse clássico do cinema moderno tão maravilhoso, mas termino dizendo que Moulin Rouge fechou a trilogia da cortina vermelha de Baz Luhrmann com chave de ouro. Simplesmente esplêndido, o melhor musical de todos!",
      rating: 4.0
    )
  end
end
