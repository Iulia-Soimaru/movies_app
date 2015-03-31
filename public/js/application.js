$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('.search').click(function(event){
    event.preventDefault();
    // var openData = open("http://www.omdbapi.com/?")

    $.ajax({
      url: "http://www.omdbapi.com/?t=" + $('.title').val() + "&y=&plot=long"
      // data:
    }).done(function(data){
      $('.search_result').css({display: "block"})
      var $post_template = $('.post-template');
      $post_template.find('.image img').attr('src', data.Poster);
      $post_template.find('.title span').text(data.Title);
      $post_template.find('.year span').text(data.Year);
      $post_template.find('.duration span').text(data.Runtime);
      $post_template.find('.actors span').text(data.Actors);
      $post_template.find('.director span').text(data.Director);
      $post_template.find('.rating span').text(data.imdbRating);


      // $('.search_result').append("<div class='post'>");
      // $('.post').append("<div class='image'>");
      // $('.post .image').append('<img class="poster" src="' + data.Poster + '">')
      // $('.post').append('</div>');

      // $('.post').append('<div class="movie_description">');
      // $('.post .movie_description').append('<p>Title: ' + data.Title + '</p>');
      // $('.post .movie_description').append('<p>Year: ' + data.Year + '</p>');
      // $('.post .movie_description').append('<p>Duration: ' + data.Runtime + '</p>');
      // $('.post .movie_description').append('<p>Actors: ' + data.Actors + '</p>');
      // $('.post .movie_description').append('<p>Rating: ' + data.imdbRating + '</p>');
      // $('.post').append('</div>');

      $('.search_result').append($post_template);
      $('.title').val('')

    }).fail(function(){
      console.log('call failed!')
    });
  });


///////////////////////////////////////////////////////////////////

  $('.')
});
