$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('.search').click(function(event){
    event.preventDefault();

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
        $post_template.find('.trailer a').attr('href', 'https://www.youtube.com/results?search_query=' + data.Title + '+trailer');


        $('.search_result').append($post_template);
        $('.title').val('');
        $('.hidden').show();
      }



    }).fail(function(){
      console.log('call failed!')
    });
  });


///////////////////////////////////////////////////////////////////

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
    console.log(title);
    $.ajax({
      url: $('.add_form').attr('action'),
      type: "post",
      data: {title: $(title).text(), }
    }).done(function(response){
      console.log(response)
      console.log($('.all_movies'))
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
    var ratingId = $(this).closest('div')[0];
    var myRating = $(this).find('a').attr('class');
    var spanWithNumber = $($(ratingId).find('span')[0]).text(myRating)[0];
    var link = $(this).parent().parent().attr('action');
    debugger
    console.log(link)
    // console.log($(rate).text())
    $.ajax({
      url: link,
      type: "post",
      data: {rate_value: $(spanWithNumber).text()}
    }).done(function(data){
      console.log(data)
      $(ratingId).find('span').text(data.rate_value)
    }).fail(function(){
      // debugger
      alert("fail")})
      $(this).parent().hide()

  });



});
