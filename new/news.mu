<!doctype html>
<html lang="en">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="/styles/base.css">
<link rel="stylesheet" href="/styles/main.css">
<link rel="stylesheet" href="/components/font-awesome/css/font-awesome.css">

<title>Православное братство в честь святителя Спиридона Тримифунтского</title>

<div class="page">

  <header class="text">
    <div class="icon"></div>
    <h1>Православное братство<br>в честь святителя Спиридона Тримифунтского</h1>
  </header>

  <nav role="navigation"></nav>

  <p><a href="/">Назад</a></p>

  <article class="flexbox flex-col flex-start news">
    {{#news}}
    <header class="text">
      <h3>{{title}}</h3>
      <h5>
        {{#formatDate}}
        <time>{{date}}</time>
        {{/formatDate}}
      </h5>
    </header>

    <div class="text flex1">
      {{{full_body}}}
    </div>
    {{/news}}
  </article>

</div>