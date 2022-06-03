document.getElementById("header").addEventListener('click', clickBannerForm);
document.getElementById('banner_file').addEventListener('change', submitBannerForm);

document.getElementById('profile_pic').addEventListener('click', clickAvatarForm); 
document.getElementById('avatar_file').addEventListener('change', submitAvatarForm);

function clickBannerForm() { 
  document.getElementById('banner_file').click();
}

function submitBannerForm() {
  document.getElementById('banner_upload_form').submit();
}

function clickAvatarForm() {
  document.getElementById('avatar_file').click();
}

function submitAvatarForm() { 
  document.getElementById('avatar_upload_form').submit();
}

// credit to Anurag for Javascript at 
// https://stackoverflow.com/questions/2441565/how-do-i-make-a-div-element-editable-like-a-textarea-when-i-click-it

function divClicked() {
  var divHtml = $("#bio-text").html();
  var editableText = $("<textarea />");
  var user_id = $("#save_bio")[0].getAttribute("data-user-id");
  const BIOPATH = $("#save_bio")[0].getAttribute("data-bio-path");

  editableText.val(divHtml);
  $(this).replaceWith(editableText);
  editableText.focus();
  $("#save_bio")[0].href = `${BIOPATH}?user=${user_id}&bio=${editableText.val()}`

  $("#save_bio")[0].classList.remove("hidden");
  // add the bio parameter to the save_bio link
  $('textarea').on('input', (event) => {
    bio = editableText.val();
    $("#save_bio")[0].href = `${BIOPATH}?user=${user_id}&bio=${bio}`;
  });
}


$("#edit_profile_button").click(divClicked)