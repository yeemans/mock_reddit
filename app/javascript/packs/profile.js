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