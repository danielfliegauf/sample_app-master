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

      function writeOnFacebook(user_uid) {
      

        // calling the API ...
        var obj = {
          method: 'send',
          to: user_uid,
          name: 'Connectify - find the perfect Sportpartner',
          link: 'http://connectify.herokuapp.com',
          redirect_uri: 'http://connectify.herokuapp.com'
          
        };

        function callback(response) {
           
        }

        FB.ui(obj, callback);
      }
      

      function postToUser(micropost, hobby, place, time, weekday, user_uid) {

          var caption_text;
          if (weekday == "11"){
            caption_text = hobby+' in '+place;
          } else {
            caption_text = hobby+' in '+place+' am '+time;
          }

        // calling the API ...
        var obj = {
          method: 'send',
          to: user_uid,
          link: 'https://connectify.herokuapp.com/micropost/'+micropost,
          name: 'schau dir mehr Infos auf Connectify an...',
          // caption: caption_text,
          description: 'Connectify - finde einen Sportpartner, der zu dir passt.'
        };

        function callback(response) {
          document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
        }

        FB.ui(obj, callback);
      }


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
          link: 'https://connectify.herokuapp.com/micropost/'+micropost,
          // picture: 'https://fbrell.com/f8.jpg',
          name: 'mehr Infos auf Connectify.de...',
          caption: caption_text,
          description: 'Connectify - finde einen Sportpartner, der zu dir passt.'
        };

        function callback(response) {
          document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
        }

        FB.ui(obj, callback);
      }