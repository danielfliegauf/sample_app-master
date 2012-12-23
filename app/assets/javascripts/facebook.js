window.fbAsyncInit = function() {
    FB.init({
      appId: '147347702004703', 
      status: true, 
      cookie: true, 
      xfbml: true});
};

    // Load the SDK Asynchronously
(function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
}(document));

  //Logout FB via JavaScript SDK
$(function() {
  $('#logout').click(function(e) {
  	
  	
    FB.logout(function(response) {
    var url = $('#logout').attr('redirect_url');
    });
  });
});



      function postToFeed(micropost, hobby, place, time, weekday) {

          var caption_text;
          if (weekday == "11"){
            caption_text = hobby+' in '+place;
          } else {
            caption_text = hobby+' in '+place+' am '+time;
          }

        // calling the API ...
        var obj = {
          method: 'feed',
          link: 'https://connectify.herokuapp.com/'+micropost,
          picture: 'https://fbrell.com/f8.jpg',
          name: 'schau dir das Post-it auf Connectify an...',
          caption: caption_text,
          description: 'Connectify - find the right people'
        };

        function callback(response) {
          document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
        }

        FB.ui(obj, callback);
      }