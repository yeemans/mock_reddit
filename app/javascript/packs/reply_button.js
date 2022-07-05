function create_reply_box() {   
    $.ajax({
        type: 'GET',
        url: this.href,
        dataType: 'script', 
        data: {parent_id: this.id}
    })
    return false;
}


function assign_reply_links(buttons) {
    for (let i = 0; i < buttons.length; i++) { 
        buttons[i].onclick = create_reply_box;
    }; 
}

assign_reply_links($(".reply-button"));


