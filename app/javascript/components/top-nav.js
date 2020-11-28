const initTopnav = () => {
  const topNav = document.getElementById('top-nav');
  const title = document.getElementById('title');
  const secondTitle = document.getElementById('second-title');
  
  if (title) {
    const rect = title.getBoundingClientRect();
    secondTitle.classList.add('hidden');
    window.addEventListener('scroll', () => {
      if (window.scrollY >= (rect.top)) {
        secondTitle.classList.remove('hidden');
        // topNav.classList.add('top-nav-border');
      } else if (window.scrollY < (rect.top)) {
        secondTitle.classList.add('hidden');
        // topNav.classList.remove('top-nav-border');
      }
    });
  }

}

export { initTopnav }