$ -> 
  $(".event-short").click (e) -> 
    $(this)
      .parent()
      .find(".event-more")
      .toggleClass("active")
    $(this)
      .find(".event-state")
      .removeClass("new")