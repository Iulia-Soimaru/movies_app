$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('.search').click(function(event){
    event.preventDefault();
    // var openData = open("http://www.omdbapi.com/?")
    // var title = function(data){

    // }

    $.ajax({
      url: "http://www.omdbapi.com/",
      data: {
        t: $('.title').val(),
        y: null,
        plot: 'long',
      },
    }).done(function(data){
      $('.search_result').css({display: "block"})
      if (data.Response === "False"){
        $('.search_result').append("<h3>Sorry this movie wasn't found <br />Try again</h3>");
        $('.post-template').hide();
      } else {
        var $post_template = $('.post-template');
        if (data.Poster === "N/A"){
          $post_template.find('.image img').attr('src', "http://www.filmfodder.com/reviews/images/poster-not-available.jpg")
        } else {
        $post_template.find('.image img').attr('src', data.Poster);
        };

        $post_template.find('.title span').text(data.Title);
        $post_template.find('.year span').text(data.Year);
        $post_template.find('.duration span').text(data.Runtime);
        $post_template.find('.actors span').text(data.Actors);
        $post_template.find('.director span').text(data.Director);
        $post_template.find('.rating span').text(data.imdbRating);


        $('.search_result').append($post_template);
        $('.title').val('');
        $('.hidden').show();
      }
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


    }).fail(function(){
      console.log('call failed!')
    });
  });


///////////////////////////////////////////////////////////////////

  // var $offsetTop = $('.search_result').offset().top;
  $('.search').on('click', function(){
    $('body').animate({
      scrollTop: $(window).height()
    }, 1000);
  });

  $('.back').on('click', function(){
    $('body').animate({
      scrollBottom: $(document).height() - $(window).height()
    }, 1000);
  });

  $('.signup').on('click', function(event){
    event.preventDefault();
    $('.overlay').css({display: "block"});
    $('.popup_signup').css({display: "block"});
  });

  $('.signin').on('click', function(event){
    event.preventDefault();
    console.log($('.overlay'))
    $('.overlay').css({display: "block"});
    $('.popup_signin').css({display: "block"});
  });

  $('.search_friends').on('click', function(event){
    event.preventDefault();
    $('.overlay').css({display:"block"});
    $('.search_people').show();
    $('.search_name').val('');
  })

  $('.list_of_friends').on("click", function(event){
    event.preventDefault();
    $('.overlay').show();
    $('.list_of_my_friends').show();
  })

    $(document).on('click', '.overlay',function() {
        $('.overlay, .popup_signup, .popup_signin, .search_people, .list_of_my_friends').fadeOut('2000',function(){//use 3000 in place of 300m
            // $('.overlay').remove();
        });
        return false;
    });
///////////////////////////////////////////////////////////////////

  $('.add_to_watched').on('click', function(event){
    event.preventDefault();
    // debugger
    var title = $('p.title span')[0];
    $.ajax({
      url: $('.add_form').attr('action'),
      type: "post",
      data: {title: $(title).text()}
    }).done(function(response){
      $('.all_movies').append(response.title)
    });
      alert("You successfully added movie to your list")
  })

  $('.add_to_friends').on('click', function(event){
    event.preventDefault();
    alert("This person was successfully added to your friends list");

    $.ajax({
      url: $('.add_person').attr('action'),
      type: 'post',
      data: {person_name: $('h3 span').text()}
    }).done(function(response){
      // console.log(response);
    $('.list_of_my_friends').append('<p>'+ response.person_name + '</p>')
    });

  });
  // $('.add_to_friends').val('already your friend')
  //   $('.add_to_friends').css({background: "orange"})
///////////////////////////////////////////////////////////////////
// RATINGS ////////////////////////////////////////////////////////
  $('.star').on('click', function(event){
    event.preventDefault();
    // debugger
    var myRating = $(this).find('a').attr('class')
    var link = $(this).parent().parent().attr('action')
    console.log(myRating)
    console.log(link)
    // debugger
    // console.log($(this).parent().parent().attr('action'))
    $.ajax({
      url: link,
      type: "POST",
      data: {my_rate: myRating}
    }).done(function(data){
      console.log(data)
    })

    // .success(function(){
    //   alert("yay")
    // }).fail(function(){alert('fail')})




    $('.rating_stars').hide()
    $('.my_rating span').text(myRating)
  });


});
