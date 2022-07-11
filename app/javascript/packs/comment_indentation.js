function last(array) { 
    return array[array.length - 1];
  }



for (let i = 0; i < $(".comment").length; i++) { 

last($(".comment")).style.marginLeft = "5%";

// offset the margin if comments are too indented
if (last($(".comment")).offsetWidth < window.innerWidth * 0.5) {  
    last($(".comment")).style.marginLeft = "0%";
}
}