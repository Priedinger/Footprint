const initProgressBar = () => {
  const circle = document.querySelector('.progress-circle');
  const barre = document.querySelector('.progress-barre');
  const barre50 = document.querySelector('.progress-sup50');

  if (circle){
    const valeur = circle.getAttribute('data-value');
    if (valeur < 33) {
      barre.style.borderColor = "#FF5154";
      barre50.style.borderColor = "#FF5154";
    } else if (valeur < 66) {
      barre.style.borderColor = "#E67E22";
      barre50.style.borderColor = "#E67E22";
    } else {
      barre.style.borderColor = "#0AAF90";
      barre50.style.borderColor = "#0AAF90";
    }
  }
}
export { initProgressBar }
