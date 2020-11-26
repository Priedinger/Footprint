const initNavbar= () => {
  const btnContainer = document.getElementById('navbar');
  const btns = btnContainer.querySelectorAll('nav-button');
  
  for (let i = 0; i < btns.length; i++) {
    console.log(i);
    btns[i].addEventListener("click", function() {
      var current = document.getElementsByClassName("active");
      current[0].className = current[0].className.replace(" active", "");
      this.className += " active";
    });
  }
}

export { initNavbar }