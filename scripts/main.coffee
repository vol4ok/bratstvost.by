window.app = angular.module("bratstvost-app", ['ngSanitize'])

moment.lang('ru')


DATA = {
  "last_update": "2013-09-30T17:15:00.000+0300",
  "news": [
    {
      "date": "2013-09-19",
      "text": "<p>Братчики с отцом Николаем <i>(духовником Братства святителя Спиридона)</i> по милости Божией приняли в дар от брата Константина для храма Преображения Господня в г.Заславль частичку святых мощей преподобного Сергия Радонежского. Святыня будет находиться в храме, а также по благословению отца настоятеля будет вывозиться для поклонения в инернаты. <b>Слава Богу за чудный дар!</b></p>"
    },
    {
      "date": "2013-09-09T18:33:49.771Z",
      "text": "<p>Возможность помогать больным людям — это дар Божий — Сергей Довгаль о служении в психоневрологических интернатах.</p><p><a class=\"btn btn-info btn-sm more\" href=\"http://www.youtube.com/watch?v=p5k_0m0wEy8&feature=player_embedded&list=UU-Vlk4PCO82-yKzt6zxkN0g\">Смотреть видео →</a></p>"
    },
    {
      "date": "2013-09-29T17:20:00.000+0300",
      "text": "<p>Австралийский гитарист Tom Ward в психоневрологическом интернате</p><p><a class=\"btn btn-info btn-sm more\" href=\"http://www.youtube.com/watch?list=UU-Vlk4PCO82-yKzt6zxkN0g&v=CESgW38kg-8&feature=player_detailpage\">Смотреть видео →</a></p>"
    }
  ],
  "events": [
    {
      "date": "2013-08-29T21:00:00.000Z",
      "title": "Визит <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне волонтеров из <a href=\"https://www.facebook.com/blueskytalentcompany\">BlueSky</a>",
      "body": "Визит <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне волонтеров из <a href=\"https://www.facebook.com/blueskytalentcompany\">BlueSky</a> и братом Сергием. Мастер-класс по иллюзии, обучение, игры.",
      "event_time": "10:00",
      "event_place": "ПНИ в Дражне",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-08-29T21:00:00.000Z",
      "title": "Выезд в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> г. Молодечно",
      "body": "Выезд в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> г. Молодечно, с Дмитрием Каминским (поэт и исполнитель, финалист проекта \"Фабрика звезд\"). Перед выступлением будет проводиться встреча с волонтерами из <a href=\"https://www.facebook.com/blueskytalentcompany\">BlueSky</a> — мастер-класс по иллюзии, обучение, игры",
      "meeting_time": "13:00",
      "meeting_place": "ст. м. Каменная Горка",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-08-30T21:00:00.000Z",
      "title": "Поездка в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> д. Тарасики",
      "meeting_time": "12:00",
      "meeting_place": "<i>уточнять по телефону у брата Сергия</i>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-03T21:00:00.000Z",
      "title": "Поездка в Столбцовский <abbr title=\"Психоневрологический интернат\">ПНИ</abbr>",
      "meeting_time": "12:00",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-04T21:00:00.000Z",
      "title": "Фестиваль «Чулае сэрца»",
      "body": "Принимаем участие в фестивале «Чулае сэрца» для детей с особенностями психофизического развития, детей инвалидов, онкобольных.",
      "event_place": "Агроусадьба «Велюна», д. Бровки",
      "meeting_time": "10:30",
      "meeting_place": "Свято-Елисаветинский монастырь",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-05T21:00:00.000Z",
      "title": "Выезд с <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Семашко в Логойск",
      "body": "Везем проживающих <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Семашко в Логойск на святой источник",
      "organizer": "брат Сергий, отец Родион",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-05T21:00:00.000Z",
      "title": "Молебен в храме Преображения",
      "body": "В храме Преображения Господня в Заславле состоится молебен для паломников из Заславля. Просьба быть всем, без опозданий.",
      "event_time": "17:00",
      "event_place": "храм Преображения Господня в г. Заславле",
    }
    {
      "date": "2013-09-05T21:00:00.000Z",
      "title": "Поездка в Лавришево",
      "body": "<p><b>С 6 по 8 сентября</b> паломническая поездка с послушанием в Свято-Елисеевский мужской монастырь в Лавришево</p><ul><li>Постельные принадлежности выдадут</li><li>Кормить будут</li><li>Взять теплые вещи — осень на дворе</li><li>Старшим в группах взять по чайнику</li></ul><p>Просьба, также взять с собой жертвочку для монастыря, хотябы 50000 бел. рублей</p>",
      "meeting_time": "<br>18:00 — <b>Минск</b><br>17:00 — <b>Заславль</b>, ",
      "meeting_place": "<br>ст.м Петровщина <i>(стоянка Макдональдс)</i> — <b>Минск</b><br>храм Преображения Господня — <b>Заславль</b>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>",
      "cost": "<b>70 000</b> бел. рублей"
    },
    {
      "date": "2013-09-10T21:00:00.000Z",
      "title": "Выезд <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Молодечно в г.Логойск",
      "body": "<ul><li>Молебен в храме святителя Николая</li><li>Купание в святом источнике</li><li>Трапеза</li></ul>",
      "event_place": "храм св. Николая в г. Логойск",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-10T21:00:00.000Z",
      "title": "Посещение <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне",
      "event_time": "18:00",
      "event_place": "ул. Ваупшасова, д. 33",
      "organizer": "сестра Татьяна",
      "phone": "<a href=\"phone:+375291432177\">8 (029) 143-21-77</a>"
    },
    {
      "date": "2013-09-11T21:00:00.000Z",
      "title": "Концерт Д.Каминского в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Новинках",
      "body": "<p>Cольный концерт Дмитрия Каминского в детском <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Новинках</p>",
      "event_time": "11:00",
      "event_place": "ул. Выготского, д. 16",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-12T21:00:00.000Z",
      "title": "Экскурсия для <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне по г.Минску",
      "body": "Обзорная экскурсия насельников <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне по г.Минску</p>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-13T21:00:00.000Z",
      "title": "Выезд <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Тарасики в г.Логойск",
      "body": "<ul><li>Молебен в храме святителя Николая</li><li>Купание в святом источнике</li><li>Трапеза</li></ul>",
      "event_place": "храм св. Николая в г. Логойск",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-14T21:00:00.000Z",
      "title": "Выход <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне в храм",
      "body": "Выход с проживающими из ПНИ в Дражне в храм в честь иконы Божией Матери «Донская»",
      "event_time": "9:00",
      "event_place": "ул. Ваупшасова, д. 33",
      "organizer": "брат Алексей",
      "phone": "<a href=\"phone:+375296202075\">8 (029) 620-20-75</a>"
    },
    {
      "date": "2013-09-17",
      "title": "Посещение <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне",
      "event_time": "18:00",
      "event_place": "ул. Ваупшасова, д. 33",
      "organizer": "сестра Татьяна",
      "phone": "<a href=\"phone:+375291432177\">8 (029) 143-21-77</a>"
    },
    {
      "date": "2013-09-18",
      "title": "Выезд <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Куль в г.Логойск",
      "body": "<ul><li>Молебен в храме святителя Николая</li><li>Купание в святом источнике</li><li>Трапеза</li></ul>",
      "event_place": "храм св. Николая в г. Логойск",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-19",
      "title": "Концерт ПНИ в Дражне для братчиков",
      "body": "Праздничный концерт проживающих ПНИ в Дражне для братчиков",
      "event_time": "10:00",
      "event_place": "ул. Ваупшасова, д. 33",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-20",
      "title": "Выезд Борисовского <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> г.Логойск",
      "body": "<ul><li>Молебен в храме святителя Николая</li><li>Купание в святом источнике</li><li>Трапеза</li></ul>",
      "event_place": "храм св. Николая в г. Логойск",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-21",
      "title": "Престольный Праздник в храме Рождества Пресвятой Богородицы",
      "body": "В нашем Благочинии, в храме Рождества Пресвятой Богородицы, в Старом селе, состоится праздничная Литургия",
      "event_time": "10.00 <i>(начало Литургии)</i>",
      "event_place": "п. Старое село",
      "meeting_place": "ст. м. Каменная горка",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-24",
      "title": "Выезд в дет. интернат в Молодено",
      "body": "Выезд с Дмитрием Каминским в детский, интернат с проблемами зрения в г. Молодечно",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-25",
      "title": "Выступление Тома Уорда в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне",
      "body": "<p>В <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне выступление Тома Уорда <i>(гитарист из Австралии)</i></p>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-26",
      "title": "Выступление Тома Уорда в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Тарасики",
      "body": "<p>В <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Тарасики выступление Тома Уорда <i>(гитарист из Австралии)</i></p>",
      "meeting_time": "9:00",
      "meeting_place": "ст. м. Уручье",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-27",
      "title": "Выступление Тома Уорда в <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> Куль",
      "body": "<p>В <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Куль выступление Тома Уорда <i>(гитарист из Австралии)</i></p>",
      "meeting_time": "9:00",
      "meeting_place": "стоянка возле ТЦ «Простор» <i>(Малиновка)</i>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-29",
      "title": "Выезд <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне на Литургию в Заславле",
      "body": "<p>В храме Преображения Господня в Заславле после Божественной Литургии отслужится молебен преп. Сергию Радонежскому, у ковчежка с частицей мощей всеми нами почитаемого святого. В молебне примут участие наши друзья из <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Дражне.</p>",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-09-30",
      "title": "Собрание Братства",
      "body": "Приглашены гости.",
      "event_time": "19:00",
      "event_place": "Приход в честь иконы Божией Матери «Всех Скорбящих Радость»",
    },
    {
      "date": "2013-10-02",
      "title": "Выезд в детский интернат г.Молодечно с Д.Каминским",
      "body": "<p>Выезд в детский интернат с проблеммами со зрением в г. Молодечно с Д. Каминским <i>(сольное выступление)</i></p>",
      "event_time": "15:00",
      "event_place": "Детский интернат с проблеммами со зрением в г. Молодечно",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-10-04",
      "title": "Выезд Борисовского <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> в Логойск на источник",
      "event_place": "храм св. Николая в г. Логойск",
      "organizer": "брат Сергий",
      "phone": "<a href=\"phone:+375293737250\">8 (029) 373-72-50</a>"
    },
    {
      "date": "2013-10-05",
      "title": "Выход <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> г. Молодечно на Божественную Литургию",
      "body": "Выход с насельниками <abbr title=\"Психоневрологический интернат\">ПНИ</abbr> г. Молодечно в ближайший храм на Божественную Литургию",
      "organizer": "сестра Ангелина",
      "phone": "<a href=\"phone:+375291597704\">8 (029) 159-77-04</a>"
    }

  ] 
}

class NewsListCtrl

  $scope = {}

  constructor: (scope) ->
    $scope = scope extends $scope
    data   = DATA

    $scope.data = {}
    $scope.data.news = DATA.news

    $scope.data.news.sort (a,b) -> 
      moment(b.date).valueOf() - moment(a.date).valueOf()

    for news in $scope.data.news
      news.timeAgo = moment(news.date).fromNow()



class EventListCtrl
  $scope = {}

  parse_phone = (phone) ->
    res = ""
    for c,i in phone
      res += c if c in "+0123456789".split("")
    return {
      nums: res.slice(-7)
      code: res.slice(-9,-7)
    }

  format_phone_nice = (p) ->
    p = parse_phone(p) if typeof p is "string"
    n = p.nums.split("")
    return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

  format_phone_raw = (p) ->
    p = parse_phone(p) if typeof p is "string"
    return "+375#{p.code}#{p.nums}"

  $scope.formatPhone = (p) ->
    p = parse_phone(p)
    return "<a href=\"phone:#{format_phone_raw(p)}\">#{format_phone_nice(p)}</a>"

  constructor: (scope) ->
    $scope = scope extends $scope
    data   = DATA
    events = data.events

    $scope.data = {}
    $scope.data.lastUpdate = moment(data.last_update).fromNow()
    

    for ev in events when ev.phone
      ev.phone = $scope.formatPhone(ev.phone)

    for ev in events
      ev._date = moment(ev.date).toDate()
      ev.month = moment(ev.date).format("MMM")
      ev.day = moment(ev.date).format("D")
          
    $scope.data.events = events
    $scope.data.pastEvents = []
    $scope.data.nextEvents = []

    today = moment().startOf('day').toDate()


    for ev in events
      if ev._date < today
        $scope.data.pastEvents.push(ev)
      else
        $scope.data.nextEvents.push(ev)

    $scope.data.nextEvents = $scope.data.nextEvents.sort (a,b) -> a._date.valueOf() - b._date.valueOf()
    $scope.data.pastEvents = $scope.data.pastEvents.sort (a,b) -> b._date.valueOf() - a._date.valueOf()
    

app.controller "EventListCtrl", ["$scope", EventListCtrl]
app.controller "NewsListCtrl", ["$scope", NewsListCtrl]


