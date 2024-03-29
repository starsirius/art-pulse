defmodule Pulse do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(Pulse.Endpoint, []),
      # Start your own worker by calling: Pulse.Worker.start_link(arg1, arg2, arg3)
      # worker(Pulse.Worker, [arg1, arg2, arg3]),
    ] ++ Enum.map([{:partners, partners}, {:artists, artists}], fn(p) ->
      worker(Task, [Pulse.TweetReceiver, :start_link, [p]], id: elem(p, 0)) end)

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pulse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Pulse.Endpoint.config_change(changed, removed)
    :ok
  end

  # A list of selected artists.
  defp artists do
    [
      "Pablo Picasso",
      "Frank Stella",
      "Andy Warhol",
      "Jeff Koons",
      "Vincent van Gogh",
      "Van Gogh",
      "Jean-Michel Basquiat",
      "Damien Hirst",
      "Hiroshi Sugimoto",
      "Keith Haring",
      "Ed Ruscha",
      "James Turrell",
      "Takashi Murakami",
      "David Hockney",
      "Christopher Wool",
      "Frida Kahlo",
      "Henri Matisse",
      "Helen Frankenthaler",
      "Mark Rothko",
      "Sol LeWitt",
      "Barbara Kruger",
      "Donald Judd",
      "Francis Bacon",
      "Kehinde Wiley",
      "Gerhard Richter",
      "Claude Monet",
      "Roy Lichtenstein",
      "Vik Muniz",
      "Alexander Calder",
      "Jackson Pollock",
      "Julian Schnabel",
      "Alex Katz",
      "Ellsworth Kelly",
      "Chuck Close",
      "Gregory Crewdson",
      "Wolfgang Tillmans",
      "Victor Vasarely",
      "Sterling Ruby",
      "Louise Bourgeois",
      "William Eggleston",
      "Douglas Coupland",
      "Thomas Woodruff",
      "Robert Mapplethorpe",
      "Anish Kapoor",
      "John Baldessari",
      "Imi Knoebel",
      "Ansel Adams",
      "Robert Rauschenberg",
      "Tom Wesselmann",
      "Yayoi Kusama",
      "Adrian Ghenie",
      "Tracey Emin"
    ]
  end

  # A list of selected galleries and museums.
  defp partners do
    [
      "Gagosian Gallery",
      "Acquavella Galleries",
      "Mary Boone Gallery",
      "Annet Gelink Gallery",
      "Metro Pictures",
      "Blain | Southern",
      "Pace Gallery",
      "Galerie Thomas",
      "Sean Kelly Gallery",
      "Victoria Miro",
      "Yvon Lambert",
      "Cheim & Read",
      "Galerie Perrotin",
      "Petzel Gallery",
      "David Zwirner",
      "ShanghART",
      "Stephen Friedman Gallery",
      "Simon Lee Gallery",
      "Galeria Nara Roesler",
      "Lehmann Maupin",
      "KÖNIG GALERIE ",
      "Sprüth Magers",
      "Galleri Nicolai Wallner",
      "A Gentil Carioca",
      "Galeria Fortes Vilaça",
      "Almine Rech",
      "L.A. Louver",
      "Ruth Benzacar Galería de Arte",
      "Galerie Karsten Greve",
      "Contemporary Fine Arts",
      "Lisson Gallery",
      "Sikkema Jenkins & Co.",
      "Galerie Thaddaeus Ropac",
      "Goodman Gallery",
      "Andrea Rosen Gallery",
      "Helga de Alvear",
      "Private Collection, Paris",
      "Blum & Poe",
      "Long March Space",
      "Andrew Kreps",
      "Los Angeles County Museum of Art",
      "Paul Kasmin Gallery",
      "Calder Foundation",
      "Marianne Boesky Gallery",
      "White Cube",
      "ARS/Art Resource",
      "National Gallery of Art, Washington, D.C.",
      "Konrad Fischer Galerie",
      "Galerie Patrick Seguin",
      # "The Broad",
      "STPI",
      "Frith Street Gallery",
      "Yale University Art Gallery",
      "Serpentine Galleries",
      "Robert Rauschenberg Foundation",
      "Dedalus Foundation",
      "Asian Art Museum",
      "Judd Foundation",
      "San Francisco Museum of Modern Art (SFMOMA) ",
      "Dallas Museum of Art",
      "Public Art Fund",
      "Cooper Hewitt, Smithsonian Design Museum ",
      "Carpenters Workshop Gallery",
      "British Museum",
      "Walker Art Center",
      "Galerie Downtown - François Laffanour",
      "Galerie Jacques Lacoste",
      "Galerie kreo",
      "SEOMI International",
      "Jousse Entreprise",
      "Nilufar Gallery",
      "R & Company",
      "Fondation Beyeler",
      "Allan Kohl",
      "Tate Modern",
      "Galleri Bo Bjerggaard",
      "Galerie EIGEN + ART",
      "Massimo De Carlo",
      "Kukje Gallery",
      "Andréhn-Schiptjenko",
      "Galerie Bob van Orsouw",
      "Pi Artworks Istanbul/London",
      "Jack Shainman Gallery",
      "Andersen's Contemporary",
      # "GRIMM",
      # "Ludorff",
      "Pilar Corrias Gallery",
      "Chemould Prescott Road",
      "Galerie Eva Presenhuber",
      "Mai 36 Galerie",
      "Bridget Riley Studio",
      "Dennis Oppenheim studio",
      "Art Institute of Chicago",
      "Niels Borch Jensen Gallery and Editions",
      "Whitechapel Gallery",
      "Ullens Center for Contemporary Art (UCCA)",
      "Sies + Höke",
      "National Portrait Gallery",
      "Richard Phillips",
      "Seattle Art Museum",
      "Richard Diebenkorn Foundation",
      "Regina Gallery",
      "J. Paul Getty Museum",
      "Mitchell-Innes & Nash",
      "Whitney Art Party Benefit 2013",
      "Franck Laigneau",
      "Galerie Anne-Sophie Duval",
      # "Jacksons",
      # "Steinitz",
      "Matthew Marks Gallery",
      "Helen Frankenthaler Foundation",
      # "KOW",
      "Kraupa-Tuskany Zeidler",
      "Friedman Benda",
      "303 Gallery",
      "Gavin Brown's Enterprise",
      "Mendes Wood DM",
      "Xavier Hufkens",
      "neugerriemschneider",
      "Tomio Koyama Gallery",
      "PKM Gallery",
      "SCAI The Bathhouse",
      "Dominique Lévy Gallery",
      "Galerie Gmurzynska",
      "Galerie Hans Mayer",
      "Galerie Urs Meile",
      "Ben Brown Fine Arts",
      # "Paragon",
      "Marlborough Fine Art",
      # "XL Gallery",
      "Luhring Augustine",
      "Skarstedt Gallery",
      "Galerie Denise René",
      "Thomas Dane Gallery",
      "Hauser & Wirth",
      "Marian Goodman Gallery",
      "Paula Cooper Gallery",
      "Gladstone Gallery",
      "Sperone Westwater",
      "Zeno X Gallery",
      "Gió Marconi",
      "Cristina Guerra Contemporary Art",
      "Beck & Eggeling",
      "The Kate Moss Collection by Gert Elfering",
      "Fraenkel Gallery",
      # "Vilma Gold",
      "Guggenheim Museum",
      "Christie's Warhol Sale ",
      # "Vermelho",
      "Van de Weghe Fine Art",
      "Tina Kim Gallery",
      # "James Cohan",
      "Micky Schubert",
      "Mor Charpentier",
      "MOT International",
      "Rossi & Rossi",
      # "Silberkuppe",
      # "Société",
      "Soka Art",
      "Galeria Stereo",
      "RMN Grand Palais",
      "The Sam Haskins Estate ",
      "Hammer Museum ",
      # "W Magazine",
      "Victoria and Albert Museum (V&A)",
      "Mnuchin Gallery",
      "Axel Vervoordt Gallery",
      "Galerie L'Arc en Seine",
      "de Young Museum",
      "Folio Demo Partner",
      "Marlborough London",
      "Art Gallery of Ontario (AGO)",
      "The National Gallery, London",
      "Pera Museum",
      "Smithsonian Freer and Sackler Galleries",
      "Centre Pompidou",
      "Palais de Tokyo",
      "The Metropolitan Museum of Art",
      "Kiasma Museum of Contemporary Art",
      "Art Gallery of New South Wales",
      "Museum of Contemporary Art Australia (MCA)",
      "Rijksmuseum",
      "Galleri Magnus Karlsson",
      "Hirshhorn Museum and Sculpture Garden",
      "Whitney Museum of American Art",
      "Tate Liverpool",
      "Louisiana Museum of Modern Art",
      "Gwangju Biennale",
      "Statens Museum for Kunst",
      "Jeu de Paume",
      "Gagosian Shop",
      "Partner Engineering Demo",
      "Royal Academy of Arts",
      "Stedelijk Museum Amsterdam",
      "Fondation Cartier pour l’art contemporain",
      "Van Gogh Museum",
      "Gagosian - Cooke",
      "Garage Museum of Contemporary Art",
      "Musée de Cluny",
      "Musée du Louvre",
      "Musée national des arts asiatiques - Guimet",
      "Musée Rodin",
      "Musée du quai Branly",
      "Château de Fontainebleau",
      "Gagosian - Nick",
      # "PK Shop",
      "The Jewish Museum",
      "DH Private Collection",
      "Fundación Proa",
      "Gagosian - Alexandra Magnuson",
      "Gagosian - Deborah McLeod",
      "Gagosian - Benjamin Handler",
      "Gagosian - Chrissie Erpf",
      "Gagosian - Georges Armaos",
      "Gagosian - Jason Ysenburg",
      "Gagosian - Serena Cattaneo Adorno",
      "Gagosian - Rysia Murphy",
      "Gagosian - Paul Coulon",
      "Gagosian - Freja Harrell",
      "Gagosian - Jona Lueddeckens",
      "Gagosian - Elly Sistovaris",
      "Gagosian - Alexandra Robinson",
      "Gagosian - Greg Bergner",
      "Gagosian - Natalie Ruchat",
      "Gagosian - Johan Nauckhoff",
      "Gagosian - Wilf",
      "Gagosian - Miriam",
      "Queens Museum",
      "Posnett and Pastor Private Collection",
      "Philipp von Rosen Galerie",
      "Dia Art Foundation",
      "Museum of Modern Art",
      "Public Art Fund Benefit Auction 2015",
      "Gagosian - Archivist 980",
      "KW Institute for Contemporary Art",
      "The Studio Museum in Harlem",
      "Gagosian - Victoria Gelfand-Magalhaes",
      "Gagosian - Eliza Robie",
      "Gagosian - Lidia Andich",
      "Gagosian - Leeza Chebotarev",
      "Gagosian - Whitney Ferrare",
      "Yuz Museum",
      "Kunstmuseum Bern",
      "Choice Works Benefit Auction 2015",
      "Nationalmuseum",
      "The Menil Collection",
      "Museum Ludwig",
      "Pergamon Museum",
      "Bode Museum",
      "Gemäldegalerie",
      "Museum für Fotografie",
      "Neues Museum",
      "Moderna Museet ",
      "Peggy Guggenheim Collection",
      "Punta della Dogana",
      "Palazzo Grassi",
      "56th Venice Biennale",
      "Taipei Fine Arts Museum ",
      "Faurschou Foundation",
      # "Christie's",
      "Galleria degli Uffizi",
      "Fondazione Prada",
      "Galleria dell'Accademia",
      "Musée d'Orsay",
      "Musée d'Art Moderne de la Ville de Paris ",
      "Château de Versailles",
      "Legion of Honor",
      "Fondation Louis Vuitton",
      "MASS MoCA",
      "Musée Picasso Paris",
      "Kunstmuseum Basel",
      "Gagosian - Sam Orlofsky",
      "PE China Demo",
      "Pinacoteca di Brera",
      "Mori Art Museum",
      "The Sursock Museum",
      "Orta's Empty Admin",
      "Museo Nacional de Arte (MUNAL)",
      "Belvedere Museum",
      "Kunsthistorisches Museum Vienna",
      "Museum of Fine Arts, Boston",
      "Museo Thyssen-Bornemisza",
      "Museo Soumaya",
      "Museo Reina Sofía",
      "The National Art Center, Tokyo",
      "National Museum of Korea",
      "The Frick Collection",
      "Tate Britain",
      "21er Haus",
      "Sotheby's Input/Output",
      "MoMA PS1",
      "Gagosian - Xi Li",
      "Smithsonian American Art Museum",
      "Mathaf: Arab Museum of Modern Art",
      "National Gallery of Victoria ",
      "Aïshti Foundation ",
      "amfAR generationCURE Holiday Party Auction",
      "Rush Philanthropic Benefit Auction 2015",
      "Gemäldegalerie Alte Meister",
      "Gagosian - Alex Wolf",
      "National Gallery Singapore",
      "Museo Tamayo",
      "Museum Boijmans Van Beuningen ",
      "Munch Museum",
      "Montreal Museum of Fine Arts",
      "Artsy Learning",
      "Public Art Fund 2016 Spring Benefit",
      "The State Hermitage Museum",
      "National Gallery of Ireland",
      "Museo Nacional del Prado",
      "Museo Jumex",
      "White House Historical Association",
      "Planned Parenthood of New York City",
      "SFMOMA: The Modern Ball Auction",
      "National Museum of Western Art",
      "Guggenheim Museum Bilbao",
      "International Sculpture Center",
      "Les Arts Décoratifs ",
      "Watermill Center Summer Benefit Auction 2016",
      "Kimbell Art Museum",
      "Philadelphia Museum of Art",
      "The National Museum of Modern Art, Tokyo",
    ]
  end
end
