import Webcam from 'webcam-easy';


const initWebCam = () => {
  const webcamElement = document.getElementById('webcam');
  const canvasElement = document.getElementById('canvas');
  const webcam = new Webcam(webcamElement, 'user', canvasElement);
  const btn = document.getElementById('photo-take');
  
  webcam.start()
     .then(result =>{
        console.log("webcam started");
     })
     .catch(err => {
         console.log(err);
     });

  btn.addEventListener('click', function() {
    let picture = webcam.snap();
    console.log(picture);
    webcam.stop();
  })
}

export { initWebCam }