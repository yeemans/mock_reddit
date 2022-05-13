function show_models(category, categories) { 
    for (let i = 0; i < categories.length; i++) { 
        categories[i].style.display = "none";
    }
    document.getElementById(category).style.display = "block";
    console.log('test');
}
  
let subreddit_div = document.getElementById("subreddit-list");
let post_div = document.getElementById("post-list");
let user_div = document.getElementById("user-list");

let subreddit_button = document.getElementById("subreddit-category");
let post_button = document.getElementById("post-category");
let user_button = document.getElementById("user-category");

let buttons = [subreddit_button, post_button, user_button]; 
let categories = [subreddit_div, post_div, user_div];

for (let i = 0; i < buttons.length; i++) { 
    buttons[i].onclick = function(){ show_models(categories[i].id, categories) };
}

// post_button.onclick = function(){show_models(post_div.id, categories)};