<!doctype html>
<html lang="en">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="styles/base.css">
<link rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="components/font-awesome/css/font-awesome.css">

<title>Православное братство в честь святителя Спиридона Тримифунтского</title>

<div class="page">

  <header class="text">
    <div class="icon"></div>
    <h1>Православное братство<br>в честь святителя Спиридона Тримифунтского</h1>
  </header>

  <nav role="navigation"></nav>

  <sectoion>

    {{#last_update}}
    <header class="text">
      <h2>Ближайшие меропрития</h2>
      <div class="last-update"><i>обновлено {{last_update}}</i></div>  
    </header>

    {{/last_update}}

    {{#events}}
      <article class="flexbox flex-row flex-start event">

        <div class="date">
          <div class="wrap {{#getColor}}{{date}}{{/getColor}}">
            <div class="day">{{#getDay}}{{date}}{{/getDay}}</div>
            <div class="mon">{{#getMonth}}{{date}}{{/getMonth}}</div>
          </div>        
          <div class="time">
            {{#hasTime}}
              {{#getTime}}{{date}}{{/getTime}}
            {{/hasTime}}
            {{^hasTime}}
              &nbsp;
            {{/hasTime}}

            
          </div>
        </div>
        
        <div class="text flex1">
          <header>
            <h3>{{title}}</h3>
          </header>
 
          {{{desc}}}

          <div class="info">
            <ul>
              {{#info}}
                <li><i class="icon-{{icon}}"></i>{{term}}: {{{desc}}}</li>
              {{/info}}
            </ul>
          </div>
        </div>

      </article>
    {{/events}}

  </sectoion>


  <section>
    <header class="text">
      <h2>Новости</h2>
      <div class="last-update"><i>обновлено 10 минут назад</i></div>
    </header>
    <article>
      
    </article>
  </section>
</div>