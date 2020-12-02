const initProgressBar = () => {
  const circle = document.querySelector('.progress-circle');
  const barre = document.querySelector('.progress-barre');
  const barre50 = document.querySelector('.progress-sup50');

  if (circle){
    const valeur = circle.getAttribute('data-value');
    if (valeur < 33) {
      barre.style.borderColor = "#FF5154";
      barre50.style.borderColor = "#FF5154";
      circle.style.borderColor = "#FFE7E7";
    } else if (valeur < 66) {
      barre.style.borderColor = "#E67E22";
      barre50.style.borderColor = "#E67E22";
      circle.style.borderColor = "#FFF4D3";
    } else {
      barre.style.borderColor = "#0AAF90";
      barre50.style.borderColor = "#0AAF90";
      circle.style.borderColor = "#E2FFEE";
    }
  }
}
export { initProgressBar }
