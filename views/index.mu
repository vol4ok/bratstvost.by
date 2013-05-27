<!doctype html>
<meta charset="utf-8">
<meta name="keywords" content="Православное братство в честь святителя Спиридона Тримифунтского, братья, сестры, волонтеры,  милосердие, благотворительность, психоневрологический интернат, мероприятия, новости, Тарасики, Молодечно, д. Куль" />
<meta name="robots" content="index, follow">

<link rel="stylesheet" href="/css/base.css">
<link rel="stylesheet" href="/css/main.css">

<script src="/js/kernel.js"></script>
<script src="/js/main.js"></script>

<title>Братство в честь святителя Спиридона Тримифунтского</title>

<section class="modals">

  <div 
    class="autoload modal video backdrop" 
    id="video-modal"
    data-class="UIVideoModal">
    <div class="modal-view">
      <div class="x">ЗАКРЫТЬ</div>
      <header>
        <h3>Десница Святителя Спиридона в Жировичах</h3>
      </header>
      <section class="modal-body">
      </section>
      <footer></footer>
    </div>
  </div>


</section>



<div class="autoload main-container" data-class="UIPage" id="page">

  <header class="global-header">
    <div class="icon"></div>
    <div class="name">
      <h1>Братство в честь святителя Спиридона Тримифунтского</h1>
    </div>
  </header>
  
  <div class="columns">








    <!-- NEWS -->

    <div class="main-content-col">


      <section class="autoload news-list" id="news-list" data-class="UINewsList">

        <article class="news-view clickable" data-class="UINewsView" data-video-id="nN8Fp-ufgOg">
          <figure class="news-img video">
            <img src="/img/200513-nN8Fp-ufgOg.jpg" alt="Десница Святителя Спиридона в Жировичах">
          </figure>
          <p class="news-date"><time pubdate datetime="2013-05-20">20 мая</time></p>
          <p class="news-body">Видео «Десница Святителя Спиридона в Жировичах»</p>
        </article>

        <article class="news-view clickable" data-class="UINewsView" data-video-id="DM38ALfUfrQ">
          <figure class="news-img video">
            <img src="/img/200513-DM38ALfUfrQ.jpg" alt="Святитель Спиридон Тримифунтский">
          </figure>
          <p class="news-date"><time>20 мая</time><p>
          <p class="news-body">Видео «Святитель Спиридон Тримифунтский»</p>
        </article>

      </section> 
    </div>










    <!-- EVENTS -->
    
    <div class="aside-content-col">


      <section class="events-list">
      
        <section>

          <header>
            <h2><i class="icon-calendar"></i> Мероприятия</h2>
            <p class="small">Обновлено <em>десять минут назад</em></p>
          </header>
                
          {{#events}}
          <article class="event-view">

            <div class="event-short">
              <div class="event-state"></div>
              {{#date}}
              <div class="event-date">
                <div class="day">{{#formatDate}}D{{/formatDate}}</div>
                <div class="month">{{#formatDate}}MMM{{/formatDate}}</div>
              </div>
              {{/date}}
              {{^date}}
              <div class="event-date">
                <div class="day">?</div>
                <div class="month">---</div>
              </div>
              {{/date}}
              <div class="event-head">{{{head}}}</div>
            </div>

            <div class="event-more">
              {{#body}}
                <div class="event-body">
                  {{{body}}}
                </div>
              {{/body}}
              <dl>

                {{#event_place}}
                  <dt><i class="icon-map-marker"></i> Место проведения</dt>
                  <dd>{{{event_place}}}</dd>
                {{/event_place}}

                {{#event_time}}
                  <dt><i class="icon-time"></i> Время проведения </dt>
                  <dd>{{#formatDate}}dddd, D MMMM YYYY [в] H:mm{{/formatDate}}</dd>
                {{/event_time}}
              
                {{#meeting_place}}
                  <dt><i class="icon-map-marker"></i> Место сбора</dt>
                  <dd>{{meeting_place}}</dd>
                {{/meeting_place}}

                {{#meeting_time}}
                  <dt><i class="icon-time"></i> Время сбора</dt>
                  <dd>{{#formatDate}}dddd, D MMMM YYYY [в] H:mm{{/formatDate}}</dd>
                {{/meeting_time}}
              
                {{#priest}}
                  <dt><i class="icon-user"></i> Священник</dt>
                  <dd>{{priest}}</dd>
                {{/priest}}
              
                {{#organizer}}
                  <dt><i class="icon-user"></i> Организатор</dt>
                  <dd>{{organizer}}</dd>
                {{/organizer}}

                {{#phone}}
                  <dt><i class="icon-phone"></i> Телефон</dt>
                  <dd><a href="phone:{{phone}}">{{#formatPhone}}{{/formatPhone}}</a></dd>
                {{/phone}}

                {{#custom_fields}}
                  <dt><i class="icon-{{icon}}"></i> {{term}}</dt>
                  <dd>{{{desc}}}</dd>
                {{/custom_fields}}
              </dl>
            </div>
          </article>
          {{/events}}

        </section>

        <section class="archive">

          <header>
            <h2><i class="icon-calendar"></i> Архив событий</h2>
          </header>

        </section>

      </section>
    </div>

  </div>
</div>