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
      age_range: AgeRange.last,
      synopsis: 'Em um mundo onde é possível entrar na mente humana, Cobb (Leonardo DiCaprio) está entre os melhores na arte de roubar segredos valiosos do inconsciente, durante o estado de sono. Além disto ele é um fugitivo, pois está impedido de retornar aos Estados Unidos devido à morte de Mal (Marion Cotillard). Desesperado para rever seus filhos, Cobb aceita a ousada missão proposta por Saito (Ken Watanabe), um empresário japonês: entrar na mente de Richard Fischer (Cillian Murphy), o herdeiro de um império econômico, e plantar a ideia de desmembrá-lo. Para realizar este feito ele conta com a ajuda do parceiro Arthur (Joseph Gordon-Levitt), a inexperiente arquiteta de sonhos Ariadne (Ellen Page) e Eames (Tom Hardy), que consegue se disfarçar de forma precisa no mundo dos sonhos.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/movies/inception.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Moulin Rouge!",
      title: 'Moulin Rouge! Amor em vermelho',
      year: 2001,
      length: 127,
      release: DateTime.parse("01/06/2001"),
      brazilian_release: DateTime.parse("24/08/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'Christian (Ewan McGregor) é um jovem escritor que possui um dom para a poesia e que enfrenta seu pai para poder se mudar para o bairro boêmio de Montmartre, em Paris. Lá ele recebe o apoio de Henri de Toulouse-Latrec (John Leguizamo), que o ajuda a participar da vida social e cultural do local, que gira em torno do Moulin Rouge, uma boate que possui um mundo próprio de sexo, drogas, adrenalina e Can-Can. Ao visitar o local, Christian logo se apaixona por Satine (Nicole Kidman), a mais bela cortesã de Paris e estrela maior do Moulin Rouge.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/movies/moulin_rouge.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Once",
      title: 'Apenas uma vez',
      year: 2007,
      length: 85,
      release: DateTime.parse("15/06/2007"),
      brazilian_release: DateTime.parse("15/06/2007"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'Dublin, Irlanda. Um músico de rua (Glen Hansard) sente-se inseguro para apresentar suas próprias canções. Um dia ele encontra uma jovem mãe (Markéta Inglová), que tenta ainda se encontrar na cidade. Logo eles se aproximam e, ao reconhecer o talento um do outro, começam a ajudar-se mutuamente para que seus sonhos se tornem realidade.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/movies/once.jpg'))
    object.save

    object = Movie.find_or_create_by(
      original_title: "Donnie Darko",
      title: 'Donnie Darko',
      year: 2001,
      length: 104,
      release: DateTime.parse("26/10/2001"),
      brazilian_release: DateTime.parse("26/10/2001"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'Donnie (Jake Gyllenhaal) é um jovem brilhante e excêntrico, que cursa o colegial mas despreza a grande maioria dos seus colegas de escola. Donnie tem visões, em especial de um coelho monstruoso o qual apenas ele consegue ver, que o encorajam a realizar brincadeiras destrutivas e humilhantes com quem o cerca. Até que um dia uma de suas visões o atrai para fora de casa e lhe diz que o mundo acabará dentro de um mês. Donnie inicialmente não acredita na profecia, mas momentos depois um avião cai bem no telhado de sua casa, quase matando-o. É quando ele começa a se perguntar qual o fundo de verdade da sua previsão.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/movies/donnie.jpg'))
    object.save

    # -------------------------------- Diretores ------------------------------

    Professional.find_or_create_by(
      name: 'Christopher Nolan',
      set_function: SetFunction.find_by(name: 'Direção')
    )

    # -------------------------------- Roteirista ------------------------------

    Professional.find_or_create_by(
      name: 'Christopher Nolan',
      set_function: SetFunction.find_by(name: 'Roteiro')
    )

    # -------------------------------- Elenco ------------------------------

     Professional.find_or_create_by(
      name: 'Leonardo DiCaprio',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Marion Cotillard',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Ellen Page',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Cillian Murphy',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Michael Caine',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Joseph Gordon-Levitt',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Ken Watanabe',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Tom Hardy',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Tom Berenger',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Lukas Haas',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Talulah Riley',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    Professional.find_or_create_by(
      name: 'Yuji Okumoto',
      set_function: SetFunction.find_by(name: 'Elenco')
    )

    # ------------------------ Profissionais em Filmes -------------------------

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Leonardo DiCaprio',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Dom Cobb'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Marion Cotillard',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Mal'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Ellen Page',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Ariadne'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Cillian Murphy',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Fischer'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Michael Caine',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Miles'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Joseph Gordon-Levitt',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Arthur'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Ken Watanabe',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Saito'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Tom Hardy',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Eames'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Tom Berenger',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Browning'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Lukas Haas',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Nash'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Talulah Riley',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Loira'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Elenco'),
      professional: Professional.find_by(
                      name: 'Yuji Okumoto',
                      set_function: SetFunction.find_by(name: 'Elenco')
                    ),
      observation: 'Assistente de Saito'
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Roteiro'),
      professional: Professional.find_by(
                      name: 'Christopher Nolan',
                      set_function: SetFunction.find_by(name: 'Roteiro')
                    )
    )

    FilmableProfessional.find_or_create_by(
      filmable: Movie.find_by(original_title: 'Inception'),
      set_function: SetFunction.find_by(name: 'Direção'),
      professional: Professional.find_by(
                      name: 'Christopher Nolan',
                      set_function: SetFunction.find_by(name: 'Direção')
                    )
    )

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
      age_range: AgeRange.last,
      synopsis: 'Com pouca supervisão dos adultos e muitas festas, um grupo de adolescentes de Bristol, na Inglaterra, tenta descobrir sobre a vida e relacionamentos. A cada duas temporadas, a série vai acompanhar um grupo de amigos diferentes, sendo que cada um deles compõe uma "geração". Na temporada 7, personagens das gerações anteriores retornam para explorar como serão suas vidas enquanto adultos.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/series/skins.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "How I Met Your Mother",
      title: 'Como Eu Conheci Sua Mãe',
      year: 2005,
      length: 25,
      release: DateTime.parse("19/09/2005"),
      brazilian_release: DateTime.parse("19/09/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'Em 2030, o arquiteto Ted Mosby (Josh Radnor) conta a história sobre como conheceu a mãe dos seus filhos. Ele volta no tempo para 2005, relembrando suas aventuras amorosas em Nova York e a busca pela mulher dos seus sonhos. Ao longo do anos, Ted aproveita para falar a jornada dos seus amigos: o advogado Marshall Eriksen (Jason Segel), a professora Lily Aldrin (Alyson Hannigan), a jornalista Robin Scherbatsky (Cobie Smulders) e o mulherengo convicto Barney Stinson (Neil Patrick Harris).'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/series/himym.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "Shameless",
      title: 'Shameless',
      year: 2011,
      length: 46,
      release: DateTime.parse("09/01/2011"),
      brazilian_release: DateTime.parse("09/01/2011"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'A série conta a história sobre a família disfuncional de Frank Gallagher (William H. Macy), um pai solteiro de seis filhos: Fiona Gallagher (Emmy Rossum), Phillip Gallagher (Jeremy Allen), Ian Gallagher (Cameron Monaghan), Debbie Gallagher (Emma Kenney), Carl Gallagher (Ethan Cutkosky) e Liam Gallagher (Brennan Kane Johnson e Blake Alexander), o único filho negro, apesar dos dois pais serem brancos. Enquanto ele passa seus dias totalmente bêbado, seus filhos precisam aprender a cuidar deles mesmos.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/series/shameless.jpg'))
    object.save

    object = Serie.find_or_create_by(
      original_title: "Doctor Who",
      title: 'Doctor Who',
      year: 2005,
      length: 45,
      release: DateTime.parse("26/03/2005"),
      brazilian_release: DateTime.parse("26/03/2005"),
      country: Country.find_by(name: 'Brasil'),
      age_range: AgeRange.last,
      synopsis: 'O Doutor é um Senhor do Tempo - um alien de um planeta distante chamado Gallifrey que tem dois corações e aproximadamente 900 anos. Em sua nave espacial, a TARDIS, ele atravessa as barreiras do espaço e do tempo lutando contra inimigos e criando aventuras com seus companheiros, que sempre escolhe para viajar junto a ele. Quando ele está prestes a morrer, ele se regenera e renasce em outro corpo inteiramente novo.'
    )
    object.cover = File.open(File.join(Rails.root, 'app/assets/images/series/doctor.jpg'))
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
      rating: 5.0,
      origin: 1,
      status: 2
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Skins').id,
      filmable_type: Serie,
      content:
        "A Série retrata sobre adolescentes que vivem suas vidas loucas e baladeiras, Skins deveria ser uma série simples, mas não foi, com um roteiro incrível, a série retrata a realidade dos adolescentes de hoje em dia, a cada geração, mais a série fica incrível com emoções e despedida de queridos personagens. Skins é uma das melhores séries da atualidade mesmo tendo seu fim em 2013.",
      rating: 4.0,
      origin: 1,
      status: 2
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Shameless').id,
      filmable_type: Serie,
      content:
        "Tá afim de se divertir ? Gosta de ser surpreendido ? Quer curtir um bom seriado ? Pronto! Shameless é a solução, mostrando a risca, o cotidiano de uma família americana, tendo o rei dos alcoólatras como pai, uma irmã mais velha um tanto quanto atraída por fazer escolhas erradas. Não fique ai parado, entre já para essa família.",
      rating: 2.5,
      origin: 1,
      status: 2
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Serie.find_by(title: 'Como Eu Conheci Sua Mãe').id,
      filmable_type: Serie,
      content:
        "How i met your mother é uma série simplesmente fantástica que te prende do início ao fim. A história é sobre Ted (Josh Radnor) contando aos seus dois filhos como conheceu a mãe deles. HIMYM é uma história muito bem contada e com excelentes atores. A série é cheia de mistérios e imprevistos para o telespectador, o que torna ela muito mais viciante a cada temporada. Os atores se encaixam muito bem em seus personagens, ao passar do tempo você vê o amadurecimento deles e se identifica. Além desses elementos, a How i met é bem engraçada e traz uma comedia típica de sitcom e episódios com elementos marcantes. Sem dúvida, HIMYM é excelente e obrigatória para amantes do gênero.",
      rating: 5.5,
      origin: 1,
      status: 2
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
      rating: 5.0,
      origin: 1,
      status: 2
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
      rating: 1.5,
      origin: 1,
      status: 2
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
      rating: 3.5,
      origin: 1,
      status: 2
    )

    Critic.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      filmable_id: Movie.find_by(title: 'Moulin Rouge! Amor em vermelho').id,
      filmable_type: Movie,
      content:
        "Moulin Rouge chama a atenção logo no inicio, com a fotografia exuberante e repleta de cores, luzes e coreografias muito bem ensaiadas. Começa em um tom de comédia, com efeitos grotescos que contrastam com as seguintes cenas de drama. Ainda que as músicas escolhidas sejam sucessos dos anos 90 e em tese não deveriam combinar em nada com o filme, elas se encaixam e harmonizam perfeitamente com o roteiro. As atuações são ótimas e a performance de Kidman é admirável, ( não é à toa que consideram essa a melhor atuação de sua carreira) seus trajes são impecáveis, sua voz é melodiosa e a atuação não menos incrível (imagino que sejam poucas as atrizes que consigam cantar, dançar e dramatizar dentro de um espartilhos, sobre saltos altos enquanto estão dependuradas à 60 pés de altura)! Ainda que, Christian te alerte sobre o final da história durante todo o desenrolar da trama, ele não deixa de comover.E eu poderia continuar enumerando mais e mais coisas que tornam esse clássico do cinema moderno tão maravilhoso, mas termino dizendo que Moulin Rouge fechou a trilogia da cortina vermelha de Baz Luhrmann com chave de ouro. Simplesmente esplêndido, o melhor musical de todos!",
      rating: 4.0,
      origin: 1,
      status: 2
    )

    # -------------------------------- Debates ---------------------------------

    Question.find_or_create_by(
      user: User.find_by(name: 'Pedro Naponoceno'),
      questionable_id: Movie.find_by(title: 'A Origem').id,
      questionable_type: Movie,
      title: 'Is this real life? Or is it just fantasy?',
      content:
        "At the end of the film it is left unknown whether Cobb is still in a dream or not. I only have one piece of evidence to prove this theory but i believe it is all the evidence i need. Throughout the film we see Cobb's children in the exact same pose, always standing together in the same positions because this is the last memory Cobb has of them before he left. At the end of the film, we see them in the exact same position we have been seeing them in every other time in the film. I believe this proves he is still dreaming because he is projecting them based on his last repeated memory of them. To argue that the fact he sees their faces at the end, he had the opportunity to see their faces every other time throuout the film but chooses to turn away before it happens, meaning he still has a memory of seeing their faces just before he originally left.",
      origin: 1,
      status: 2
    )

    Question.find_or_create_by(
      user: User.find_by(name: 'Thiago Garcia'),
      questionable_id: Professional.find_by(name: 'Leonardo DiCaprio').id,
      questionable_type: Professional,
      title: 'Cabia a Rose, cabia a Mal, cabia todo mundo naquela porta!',
      content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      origin: 1,
      status: 2
    )

    Question.find_or_create_by(
      user: User.find_by(name: 'Marquinhos'),
      questionable_id: Serie.find_by(title: 'Doctor Who').id,
      questionable_type: Serie,
      title: 'QUERO UMA TARDIS!!!!!',
      content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      origin: 1,
      status: 2
    )

    # -------------------------------- Eventos ---------------------------------
    Event.find_or_create_by(
      title: 'Oscar 2017',
      event_date: Date.parse("26/02/2017"),
      start_time: '08:00',
      end_time: '23:59',
      description: 'Oscar 2017'
    )

    Event.find_or_create_by(
      title: 'Festival de Cinema de Gramado - 45ª edição',
      event_date: Date.parse("18/08/2017"),
      start_time: '08:00',
      end_time: '23:59',
      description: 'Festival de Cinema de Gramado - 45ª edição'
    )

    Event.find_or_create_by(
      title: '70º Festival de Cannes',
      event_date: Date.parse("17/05/2017"),
      start_time: '08:00',
      end_time: '23:59',
      description: '70º Festival de Cannes'
    )

    Event.find_or_create_by(
      title: 'Festival Internacional de Filme de Madrid',
      event_date: Date.parse("08/07/2017"),
      start_time: '08:00',
      end_time: '23:59',
      description: 'Festival Internacional de Filme de Madrid'
    )
  end
end
