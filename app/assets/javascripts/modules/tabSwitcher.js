export default (() => {
  switch(window.location.hash){
    case '#documents':
      $('#documents-tab').tab('show') 
      break;
    case '#comments':
      $('#comments-tab').tab('show') 
      break;
    case '#old-advisings':
      $('#old-advisings-tab').tab('show') 
      break;
    case '#profile':
      $('#profile-tab').tab('show') 
      break;
    default:
  }

  var clickTab = function(e){
    e.preventDefault()
    $(this).tab('show')
    location.hash = $(this).attr('href').slice(1)
  }
  $('#documents-tab').click(clickTab)
  $('#comments-tab').click(clickTab)
  $('#profile-tab').click(clickTab)
  $('#old-advisings-tab').click(clickTab)

  
  
  })();
