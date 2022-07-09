function send_show_replies_request() {   
    $.ajax({
        type: 'GET',
        url: this.href,
        dataType: 'script', 
        data: {comment_id: this.id}
    })
    return false;
}


function assign_show_replies_links(buttons) {
    for (let i = 0; i < buttons.length; i++) { 
        buttons[i].onclick = send_show_replies_request;
    }; 
}

assign_show_replies_links($(".show-replies-button"));


