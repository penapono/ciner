require 'httparty'

namespace :trophies do
  desc "I'm the fastest script alive!"

  task create_or_update: :environment do
    # Top Ciner
    Trophy.find_or_create_by(
      name: "Ciner com orgulho",
      description: "Seja Ciner",
      level: :top
    )

    Trophy.find_or_create_by(
      name: "Essa é minha vida 4",
      description: "Assista a 2000 filmes ou séries",
      level: :top
    )

    Trophy.find_or_create_by(
      name: "O colecionador 4",
      description: "Tenha 500 filmes ou séries na coleção",
      level: :top
    )

    Trophy.find_or_create_by(
      name: "Ciner Sociável 4",
      description: "Tenha 100 amigos Ciner",
      level: :top
    )

    Trophy.find_or_create_by(
      name: "Secreto",
      description: "Assista a 44 filmes e séries selecionados pelos Fundadores CINER",
      level: :top
    )

    # Protagonista

    Trophy.find_or_create_by(
      name: "Essa é minha vida 3",
      description: "Assista a 1000 filmes ou séries",
      level: :leading
    )

    Trophy.find_or_create_by(
      name: "O colecionador 3",
      description: "Tenha 250 filmes ou séries na coleção",
      level: :leading
    )

    Trophy.find_or_create_by(
      name: "Ciner Sociável 3",
      description: "Tenha 50 amigos Ciner",
      level: :leading
    )

    Trophy.find_or_create_by(
      name: "Programe-se",
      description: "Assista a 10 filmes selecionados pelo Programador CINER",
      level: :leading
    )

    Trophy.find_or_create_by(
      name: "'Lembrai, lembrai do 5 de novembro.'",
      description: "Acesse o Ciner no Dia Mundial do Cinema, 05 de Novembro",
      level: :leading
    )

    # Coadjuvante

    Trophy.find_or_create_by(
      name: "Essa é minha vida 2",
      description: "Assista a 250 filmes ou séries",
      level: :supporting
    )

    Trophy.find_or_create_by(
      name: "O colecionador 2",
      description: "Tenha 100 filmes ou séries na coleção",
      level: :supporting
    )

    Trophy.find_or_create_by(
      name: "Ciner Sociável 2",
      description: "Tenha 25 amigos Ciner",
      level: :supporting
    )

    Trophy.find_or_create_by(
      name: "'Olha que coisa mais linda.'",
      description: "Assista a 50 filmes brasileiros",
      level: :supporting
    )

    Trophy.find_or_create_by(
      name: "'ET. Telefone. Minha casa.'",
      description: "Acesse o Ciner no dia em que o E.T. voltou para casa, 02 de Novembro",
      level: :supporting
    )

    # Figurante

    Trophy.find_or_create_by(
      name: "Essa é minha vida 1",
      description: "Assista a 100 filmes ou séries",
      level: :figurant
    )

    Trophy.find_or_create_by(
      name: "O colecionador 1",
      description: "Tenha 25 filmes ou séries na coleção",
      level: :figurant
    )

    Trophy.find_or_create_by(
      name: "Ciner Sociável 1",
      description: "Tenha 10 amigos Ciner",
      level: :figurant
    )

    Trophy.find_or_create_by(
      name: "Aquele do CINER",
      description: "Assista a série Friends",
      level: :figurant
    )

    Trophy.find_or_create_by(
      name: "Como eu conheci o CINER",
      description: "Assista a série How I Met Your Mother",
      level: :figurant
    )
  end
end
