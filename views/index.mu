<!doctype html>
<meta charset="utf-8">
<meta name="keywords" content="Православное братство в честь святителя Спиридона Тримифунтского, братья, сестры, волонтеры,  милосердие, благотворительность, психоневрологический интернат, мероприятия, новости, Тарасики, Молодечно, д. Куль" />
<meta name="robots" content="index, follow">

<link rel="stylesheet" href="/css/base.css">
<link rel="stylesheet" href="/css/main.css">

<script src="/js/kernel.js"></script>
<script src="/js/main.js"></script>

<script type="text/javascript">
  WebFontConfig = {
    google: { families: [ 'PT+Sans:400,700,400italic,700italic:latin,cyrillic', 'PT+Sans+Narrow:400,700:latin,cyrillic', 'PT+Serif:400,700,400italic,700italic:latin,cyrillic' ] }
  };
  (function() {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  })(); 
</script>

<title>Братство в честь святителя Спиридона Тримифунтского</title>

<section class="modals">

  <div 
    class="autoload modal video backdrop" 
    id="video-modal"
    data-class="UIVideoModal">

    <script type="text/template" id="picture-video-template">

      <div class="modal-view">

        <header class="modal-head">
          <h3><%= title %></h3>
        </header>

        <section class="modal-body">

          <iframe 
            width="480" 
            height="360" 
            src="http://www.youtube.com/embed/<%= video.id %>" 
            frameborder="0" 
            allowfullscreen>
          </iframe>

        </section>

        <footer class="modal-text">
          <%= body %>
        </footer>

        <div class="x">ЗАКРЫТЬ</div>
      </div>
    </script>

    <div class="modal-view">

      
      <header>
        <h3></h3>
      </header>
      <section class="modal-body"></section>
      <footer></footer>
      <div class="x">ЗАКРЫТЬ</div>
    </div> <!-- modal-view -->
  </div> <!-- modal -->

  <div 
    class="autoload modal picture backdrop" 
    id="picture-modal"
    data-class="UIPictureModal">

    <script type="text/template" id="picture-modal-template">

      <div class="modal-view">

        <header class="modal-head">
          <h3><%= title %></h3>
        </header>

        <section class="modal-body">

          <div class="flexslider" id="slider">
            <ul class="slides">
            
              <% for(var i=0; i<images.m.length; i++){ %>
                <li><img src="<%= images.m[i] %>" /></li>
              <% } %>
              
            </ul>
          </div>

        </section>

        <footer class="modal-text">
          <%= body %>
        </footer>

        <div class="x">ЗАКРЫТЬ</div>
      </div>
    </script>

  </div> <!-- modal -->

</section> <!-- modals -->



<div class="autoload main-container" data-class="UIPage" id="page">

  <header class="global-header">
    <div class="icon"></div>
    <div class="name">
      <h1>Братство святителя Спиридона</h1>
    </div>
  </header>
  
  <div class="columns">







    <!-- NEWS -->

    <div class="main-content-col">

      <section 
        class="autoload news-list" 
        id="news-list" 
        data-class="UINewsList">

        {{#news}}
        <article 
          class="news-view {{#clickable}}{{/clickable}}" 
          data-class="{{#classByType}}{{/classByType}}" 
          data-model="{{#base64This}}{{/base64This}}"
          >

          {{#date}}
          <p class="news-date">
            <time pubdate 
              datetime="{{#formatDate}}YYYY-MM-DD{{/formatDate}}">
              {{#fromNow}}{{/fromNow}}
            </time>
          </p>
          {{/date}}

          {{#thumb}}
          <figure class="news-img {{post_type}}">
            <img src="{{thumb}}" {{#title}}alt="{{title}}"{{/title}}>
          </figure>
          {{/thumb}}

          <div class="news-body">
            <h5 class="news-title">{{ title }}</h5>
            <p>{{{ body }}}</p>
          </div>

        </article>
        {{/news}}

      </section> <!-- news-list -->
    </div> <!-- main-content-col -->






    <!-- EVENTS -->
    
    <div class="aside-content-col">


      <section class="events-list">
      
        <section>

          <header>
            <h2><i class="icon-calendar"></i> Мероприятия</h2>
            <p class="small">Обновлено <em>
              {{#last_update}}
                {{#fromNow}}{{/fromNow}}
              {{/last_update}}
            </em></p>
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

        </section> <!-- archive -->
      </section> <!-- events-list -->
    </div> <!-- aside-content-col -->
  </div> <!-- columns -->
</div> <!-- main-container -->