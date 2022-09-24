// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require jquery-ujs
//= require rails-ujs
//= require activestorage


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "trix"
import "@rails/actiontext"
import "@hotwired/turbo-rails"



let query = document.getElementById("query"); 

query.addEventListener("keyup", function(event) {
    if (event.code == 'Enter') {
      document.getElementById("searchForm").submit();
    }
}); 

 $.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader('Content-Type', 'application/javascript');}  
 }); 

Rails.start()
Turbolinks.start()
ActiveStorage.start()


require("trix")
require("@rails/actiontext")// Support component names relative to this directory:


