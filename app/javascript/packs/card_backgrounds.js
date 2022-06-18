function set_card_backgrounds(subreddit_cards) {
  let banner;

  for (let i = 0; i < subreddit_cards.length; i++ ) { 
    banner = subreddit_cards[i].dataset.banner;
    subreddit_cards[i].style.backgroundImage = `url("${banner}")`;
  }
}

function set_link(subreddit_card) { 
  window.location.href = subreddit_card.dataset.sub_link
}

let subreddit_cards = document.querySelectorAll(".subreddit-card"); 
set_card_backgrounds(subreddit_cards);

for (let i = 0; i < subreddit_cards.length; i++) { 
  subreddit_cards[i].onclick = function(){ set_link(subreddit_cards[i]) };
}
