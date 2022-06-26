function create_upvote() {   
    $.ajax({
        type: 'GET',
        url: this.href,
        dataType: 'script', 
        data: {is_upvote: true}
    })
    return false;
}

function create_downvote() {   
    $.ajax({
        type: 'GET',
        url: this.href,
        dataType: 'script', 
        data: {is_upvote: false}
    })
    return false;
}

function assign_upvote_links(buttons) {
    for (let i = 0; i < buttons.length; i++) { 
        if (buttons[i].classList.contains("upvote-button")) {
            buttons[i].onclick = create_upvote;
        } else { 
            buttons[i].onclick = create_downvote;
        }
    }; 
}

assign_upvote_links($(".upvote-button"));
assign_upvote_links($(".downvote-button"));

