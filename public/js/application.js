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
      $('.search_result .image').append('<img class="poster" src="' + data.Poster + '">')
      $('.search_result .movie_description').append('<p>Title: ' + data.Title + '</p>')
      $('.search_result .movie_description').append('<p>Year: ' + data.Year + '</p>')
      $('.search_result .movie_description').append('<p>Duration: ' + data.Runtime + '</p>')
      $('.search_result .movie_description').append('<p>Actors: ' + data.Actors + '</p>')
      $('.search_result .movie_description').append('<p>Rating: ' + data.imdbRating + '</p>')

    }).fail(function(){
      console.log('call failed!')
    })
  })
});
