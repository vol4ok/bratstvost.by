class AboutPageCtrl

  constructor: (@$scope) ->
    map = undefined
    ymaps.ready ->
      map = new ymaps.Map "internat-map",
        center: [53.902400, 27.561892]
        zoom: 7
        controls: [new ymaps.control.ZoomControl(), new ymaps.control.FullscreenControl()]

      objects = [
        
        # Новинки - взрослый
        coord: [53.956459, 27.546367]
        label: "Минский психоневрологический дом-интернат №3"
      ,
        
        # Новинки - детский
        coord: [53.956989, 27.545892]
        label: "Детский дом-интернат для детей-инвалидов с особенностями психофизического развития"
      ,
        
        # Дражня - 1
        coord: [53.903130, 27.661171]
        label: "Минский психоневрологический дом-интернат №2"
      ,
        
      #   Дражня - 2
      #   coord: [53.902572, 27.661536]
      #   label: "Дом-интернат для пенсионеров и инвалидов"
      # ,
        
        # Тарасики
        coord: [54.101959, 28.456472]
        label: "Борисовский психоневрологический дом-интернат (д.Тарасики)"
      ,
        
        # Молодечно
        coord: [54.297003, 26.870215]
        label: "Молодечненский психоневрологический дом-интернат"
      ,
        
        # Молодечно - детский
        coord: [54.309124, 26.847636]
        label: "Школа-интернат для детей с нарушением зрения в г. Молодечно"
      ,
        
        # Куль
        coord: [53.798659, 26.744202]
        label: "Столбцовский психоневрологический дом-интернат (д. Куль)"
      ,
        # Червень
        coord: [53.707260, 28.413953]
        label: "Червенский психоневрологический дом-интернат (г. Червень)"
      ,
        # Червень
        coord: [54.875914, 26.400495]
        label: "Свирский  психоневрологический дом-интернат (д. Лущики)"
      ]

      for obj in objects
        place = new ymaps.Placemark(obj.coord, {hintContent: obj.label}, {preset: "islands#circleDotIcon", iconColor: '#5b2275'})
        map.geoObjects.add(place)


angular.module("AboutPageCtrl",[]).controller("AboutPageCtrl", ["$scope", AboutPageCtrl])