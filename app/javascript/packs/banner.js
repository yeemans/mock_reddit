console.log('mod'); 
document.getElementById("subreddit_banner").addEventListener('click', clickBannerForm);
document.getElementById('banner_file').addEventListener('change', submitBannerForm);

function clickBannerForm() { 
  document.getElementById('banner_file').click();
}

function submitBannerForm() {
  document.getElementById('banner_form').submit();
}