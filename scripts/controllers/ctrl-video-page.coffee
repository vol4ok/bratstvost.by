class VideoPageCtrl

  constructor: (@$scope) ->
    @videos = [
        {
            "id": "CSYV9Ve4GGE",
            "publish_date": "5 август, 2013",
            "title": "Белорусские артисты выступят с концертами в интернатах для людей с ограниченными возможностям",
            "content": "Благотворительный концерт в Минском психоневрологическом интернате организовало братство в честь святителя Спиридона Тримифунтского. В праздничной акции для людей с ограниченными возможностями из интернатов Минска и Минской области приняли участие более 10-ти белорусских артистов и коллективов и иллюзионист из Великобритании Эдвард Хилсом. Одним из идейных вдохновителей этого необычного концерта выступил народный артист Беларуси Александр Тиханович.",
            "url": "http://www.youtube.com/embed/CSYV9Ve4GGE?feature=player_embeded",
            "source_url": "http://sobor.by/videonews/Belorusskie_artisti_vistupyat_s_solnimi_kontsertami_v_psihonevrologicheskih_internatah"
        },
        {
            "id": "lODfMyhdXzc",
            "publish_date": "25 июль, 2013",
            "title": "Крещение в озере совершилось в Минской области",
            "content": "Традицию массового крещения в открытом водоёме возродили в Беларуси. Инициатива проведения Таинства крещения на открытом воздухе над пациентами Столбцовского психоневрологического интерната в деревне Куль принадлежит Заславльскому братству в честь Святителя Спиридона Тримифунтского. Вместе с теми, кто решил принять Православие в воду погрузился и наш корреспондент. Подробности в сюжете из Беларуси.",
            "url": "http://www.youtube.com/embed/lODfMyhdXzc?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "OGNPccyloo8",
            "publish_date": "25 июль, 2013",
            "title": "Фестиваль молодежи минской епархии в городе Заславль",
            "content": "Беларусь продолжает праздновать 1025-летие Крещения Руси. Очередной площадкой, где развернулись торжества, стал древний город Заславль, основанный, согласно летописным преданиям в конце Х века самим князем Владимиром для своего сына Изяслава, имя которого и носит белорусский город. На этой исторической земле, хранящей дух многовековой истории, связанной с распространением христианства на Руси, прошёл первый фестиваль молодёжи Минской епархии. Вместе с православными молодыми людьми по культурному слою Х века прошли и наши корреспонденты. Подробности в материале из Беларуси.",
            "url": "http://www.youtube.com/embed/OGNPccyloo8?feature=player_embeded",
            "source_url": "http://sobor.by/videonews/Perviy_festival_pravoslavnoy_molodyogi_Minskoy_eparhii_horoshee_nachalo_dlya_novoy_traditsii"
        },
        # {
        #     "publish_date": "16 июль, 2013",
        #     "title": "Освящение памятника воинам-интернационалистам",
        #     "content": "На территории военной авиационной базы под Минском освятили памятник воинам-интернационалистам.",
        #     "url": "https://vimeo.com/70393320",
        #     "source_url": "http://www.lestvitsa.dp.ua/?q=content/sedmica-vypusk-06072013-g-no432"
        # },
        # {
        #     "publish_date": "15 июль, 2013",
        #     "title": "«Девушка, пианино, дорога»",
        #     "content": "«Девушка, пианино, дорога». В Беларуси прошёл благотворителный гастрольный тур известной австралийской пианистки Эмбы Хаммонд.",
        #     "url": "https://vimeo.com/70318171",
        #     "source_url": "http://lestvitsa.dp.ua/?q=content%2Fsedmica-vypusk-22062013-g-no430"
        # },
        {
            "id": "3-_KOICoahM",
            "publish_date": "25 июня, 2013",
            "title": "В Минске накануне праздника Святой Троицы состоялся благотворительный концерт для инвалидов",
            "content": "В Минске накануне праздника Святой Троицы состоялся благотворительный концерт для инвалидов, проживающих в психоневрологических интернатах белорусской столицы и Минской области. Акцию, которую организовало православное братство в честь святителя Спиридона, поддержали знаменитые белорусские артисты и творческие коллективы.",
            "url": "http://www.youtube.com/embed/3-_KOICoahM?feature=player_embeded",
            "source_url": "http://tv-soyuz.ru/videonews/allvideos/265-pravoslavie-vne-rossii/37592-v-minske-nakanune-prazdnika-svyatoy-troitsyi-sostoyalsya-blagotvoritelnyiy-kontsert-dlya-invalidov"
        },
        {
            "id": "MWHfQzq1neM",
            "publish_date": "22 июня, 2013",
            "title": "Пусть люди поймут, что в них кто-то нуждается - протоиерей Николай Мозгов",
            "content": "Двор Минского психоневрологического интерната №2 в Дражне такого ещё не видел -- на благотворительный концерт сюда смогли привезти людей с ограниченными физическими и психическими возможностями со всех уголков Минской области и интернатов белорусской столицы. Доставили даже тех, кто и на улице бывает только раз в несколько лет. К сожалению, эти люди часто лишены самого необходимого -- простого общения, ярких эмоций. В этот раз несколько сотен насельников из разных белорусских интернатов смогли познакомиться, подружиться и друг с другом и со звездами белорусской эстрады. Эту возможность им предоставило братство святителя Спиридона Тримифунсткого. О смысле и значении этой акции в интервью с духовником братства , настоятелем Спасо-Преображенского храма в Заславле протоиереем Николаем Мозговым.",
            "url": "http://www.youtube.com/embed/MWHfQzq1neM?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "4Noc7AeCdAs",
            "publish_date": "22 июня, 2013",
            "title": "Мы хотим, чтобы о ребятах из интернатов узнало как можно больше людей -- Сергей Довгаль",
            "content": "15 артистов белорусской эстрады и лондонский гость фокусник Эдвард Хилсон выступили 20 июня перед проживающими в интернатах Минска и Минской области. Трёхчасовой концерт «1025-летию крещения Руси посвящается» состоялся под открытым небом, на территории психоневрологического интерната в Дражне. Организатором этого концерта выступило опекающее людей с ограничениями братство в честь Святителя Спиридона Тримифунтского. О том, как удалось организовать праздник для 500 особенных ребят и для чего это делалось, мы беседуем с руководителем братства Сергеем Довгалем.",
            "url": "http://www.youtube.com/embed/4Noc7AeCdAs?feature=player_embeded",
            "source_url": "http://www.sobor.by/page/Mi_hotim_chtobi_o_rebyatah_progivayushchih_v_internatah_uznalo_kak_mogno_bolshe_lyudey__Sergey_Dovgalrn"
        },
        {
            "id": "bbaV_xXjRAs",
            "publish_date": "22 июня, 2013",
            "title": "Александр Тиханович об особенном концерте для особенных зрителей",
            "content": "«Класс, супер! Мне очень понравилось.Люди такие душевные выступали перед нами.Хотим, чтобы они ещё раз к нам приехали.Мы будем их ждать», - такими восклицаниями выражали восторги от концерта в Дражне даже самые, казалось бы, сдержанные зрители. О том, какое впечатление от музыкального праздника, у самих исполнителей, мы спросили у самих артистов. Рассказывает организатор концерта, волонтёр братства в честь Святителя Спиридона Тримифунтского народный артист Беларуси Александр Тиханович.",
            "url": "http://www.youtube.com/embed/bbaV_xXjRAs?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "AyNwjaK2gCc",
            "publish_date": "22 июня, 2013",
            "title": "Сегодня праздник у каждого артиста, который выступил перед ними -- Ольга Плотникова",
            "content": "Певица и телеведущая Ольга Плотникова, которая приняла активное участие в благотворительном концерте на территории психоневрологического интерната в Дражне, своей искренностью и энергичностью заставила двигаться почти всю аудиторию. А какие впечатления от концерта у самой певицы, она рассказала в коротком интервью.",
            "url": "http://www.youtube.com/embed/AyNwjaK2gCc?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "Y9orOkPdpHo",
            "publish_date": "22 июня, 2013",
            "title": "Звёзды белорусской эстрады дали благотворительный концерт для «особенных» зрителей",
            "content": "Звёзды белорусской эстрады дали 3-часовой благотворительный гала-концерт «1025-летию Крещения Руси посвящается» для проживающих в психоневрологических интернатах Минска и Минской области и других людей с психофизическими ограничениями. Инициатором этого праздника на территории Минского психоневрологического интерната №2 в Дражне стало Братство в честь Святителя Спиридона Тиримифунтского при Спасо-Преображенском храме города Заславля. Координатором и художественным руководителем проекта стал народный артист Беларуси Александр Тиханович.",
            "url": "http://www.youtube.com/embed/Y9orOkPdpHo?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "yiJ7llFfOtw",
            "publish_date": "22 июня, 2013",
            "title": "Памятник воинам-интернационалистам освятили на территории 50-й авиационный базы",
            "content": "На территории 50-й военной смешанной авиационной базы освящён памятник воинам-интернационалистам. Памятник, который носит название «Полтинник» (так называют свой полк военнослужащие) - представляет советский военно-транспортный самолёт Ан-26, рядом – мемориальная доска, на которой список из 132 имен погибших. Самолёт, которому отведена роль мемориала, тоже являлся участником военных действий в Афганистане.",
            "url": "http://www.youtube.com/embed/yiJ7llFfOtw?feature=player_embeded",
            "source_url": "http://sobor.by/videonews/Pamyatnik_voinam_internatsionalistam_osvyatili_na_territorii_50_y_aviatsionniy_bazi"
        },
        {
            "id": "nN8Fp-ufgOg",
            "publish_date": "20 май, 2013",
            "title": "Десница Святителя Спиридона в Жировичах",
            "content": "Как встречали Десницу Святителя Спиридона в Жировичской Свято-Успенской обители.",
            "url": "http://www.youtube.com/embed/nN8Fp-ufgOg?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "DM38ALfUfrQ",
            "publish_date": "20 май, 2013",
            "title": "Святитель Спиридон Тримифунтский",
            "content": "По благословлению Митрополита Минского и Слуцкого Филарета утверждена программа пребывания ковчега с десницей Святителя Спиридона Тримифунтского в пределах Белорусской Православной Церкви: 10 - 12 май - Минск, Свято-Духов кафедральный собор. 13 - 14 май - Полоцк, Полоцкий Спасо-Евфросиньевский женский монастырь. 14 - 15 май - Жировичи, Жировичский Свято-Успенский ставропигиальный мужской монастырь. 15 - 17 май, Кобрин, Брест. 17 май, Минск, Дом милосердия в г. Минске.",
            "url": "http://www.youtube.com/embed/DM38ALfUfrQ?feature=player_embeded",
            "source_url": ""
        },
        {
            "id": "p0VvbevKlQ8",
            "publish_date": "15 май, 2013",
            "title": "Десница Святого Спиридона в Беларуси",
            "content": "Десница святителя Спиридона Тримифунсткого продолжает шествие по белорусской земле. Великую святыню доставили в Беларусь ещё 9 май, ей смогли поклониться жители Минска, древнего Полоцка, паломники, гостящие в Жировичской Свято-Успенской обители. Впереди -- пребывание святыни в Кобрине и Бресте. Последние вечер и ночь святыни на белорусской земле ее вновь будут принимать храмы Минска. Подробности из Беларуси.",
            "url": "http://www.youtube.com/embed/p0VvbevKlQ8?feature=player_embeded",
            "source_url": ""
        },
        # {
        #     "publish_date": "15 май, 2013",
        #     "title": "«Разговор на колокольне» с Александром Тихановичем",
        #     "content": "Фрагмент интервью у нашего братчика Александра Тихоновича в программе «Разговор на Колокольне»",
        #     "url": "https://vimeo.com/66309568",
        #     "source_url": "http://sobor.by/page/Aleksandr_Tihanovich_stal_geroem_novoy_programmi_Sobor_TV_Razgovor_na_kolokolne_rn"
        # },
        # {
        #     "publish_date": "3 май, 2013",
        #     "title": "Cюжет о Братстве в передаче \"Седмица\"",
        #     "content": "Отозваться на чужую боль. Волонтеры братства Святителя Спиридона Тримифунтского, опекают насельников психоневрологических интернатов",
        #     "url": "https://vimeo.com/65376123",
        #     "source_url": ""
        # }
    ]

    @$scope.videosLeft = []
    @$scope.videosRight = []

    for video,i in @videos
      if i & 1
        @$scope.videosRight.push(video)
      else
        @$scope.videosLeft.push(video)


    # @$scope.videosLeft = [ 
    #   id: 'CSYV9Ve4GGE'     
    #   url: "http://www.youtube.com/embed/CSYV9Ve4GGE?feature=player_embedded"
    #   title: "Белорусские артисты выступят с концертами в интернатах для людей с ограниченными возможностям"
    #   desc: "Donec ullamcorper nulla non metus auctor fringilla. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam quis risus eget urna mollis ornare vel eu leo."
    # ,
    #   id: 'OGNPccyloo8'
    #   url: "http://www.youtube.com/embed/OGNPccyloo8?feature=player_embedded"
    #   title: "Фестиваль молодежи минской епархии в городе Заславль"
    #   desc: "Aenean lacinia bibendum nulla sed consectetur. Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nulla vitae elit libero, a pharetra augue."
    # ]

    # @$scope.videosRight = [  
    #   id: 'OGNPccyloo8'
    #   url: "http://www.youtube.com/embed/OGNPccyloo8?feature=player_embedded"
    #   title: "Фестиваль молодежи минской епархии в городе Заславль"
    #   desc: "Aenean lacinia bibendum nulla sed consectetur. Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nulla vitae elit libero, a pharetra augue."
    # ,
    #   id: 'CSYV9Ve4GGE'
    #   url: "http://www.youtube.com/embed/CSYV9Ve4GGE?feature=player_embedded"
    #   title: "Белорусские артисты выступят с концертами в интернатах для людей с ограниченными возможностям"
    #   desc: "Donec ullamcorper nulla non metus auctor fringilla. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam quis risus eget urna mollis ornare vel eu leo."
    # ]

    

angular.module("VideoPageCtrl",[]).controller("VideoPageCtrl", ["$scope", VideoPageCtrl])