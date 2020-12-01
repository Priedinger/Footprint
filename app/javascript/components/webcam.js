import Webcam from 'webcam-easy';


const initWebCam = () => {
  const webcamElement = document.getElementById('webcam');
  const canvasElement = document.getElementById('canvas');
  const webcam = new Webcam(webcamElement, 'user', canvasElement);
  const btn = document.getElementById('pic-nav-btn');
  
  webcam.start({facingMode: 'enviroment'})
     .then(result =>{
        console.log("webcam started");
     })
     .catch(err => {
         console.log(err);
     });

  btn.addEventListener('click', function() {
    let picture = webcam.snap();
    console.log(picture);
    // webcam.stop();
    document.getElementById('ticket_photo').value = picture;
    document.getElementById('new_ticket').submit();
  })
}

export { initWebCam }