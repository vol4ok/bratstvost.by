(function() {
  $(function() {
    return $(".event-short").click(function(e) {
      $(this).parent().find(".event-more").toggleClass("active");
      return $(this).find(".event-state").removeClass("new");
    });
  });

}).call(this);
