function redirect (link) { 
    window.location.href = link;
}
// line up "join a community" with logo
let logo = document.querySelector("#logo_text");
document.querySelector("#join-a-community").style.left = logo.getBoundingClientRect().left + "px"; // The distance (length) of div from the left of screen