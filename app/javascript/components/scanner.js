import * as ScanditSDK from "scandit-sdk";

const initScanner = () => {
  const scandit = document.getElementById('scandit-barcode-picker')
  if (scandit) {
    ScanditSDK.configure(`${scandit.dataset.apikey}`, {
      engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk@5.x/build/",
    })
    .then(() => {
      return ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
        playSoundOnScan: false,
        vibrateOnScan: true,
      });
    })
    .then((barcodePicker) => {
      const scanSettings = new ScanditSDK.ScanSettings({
        enabledSymbologies: ["ean13"],
        codeDuplicateFilter: 1000,
      });
      barcodePicker.applyScanSettings(scanSettings);

      // barcodePicker is ready here, show a message every time a barcode is scanned
      barcodePicker.on("scan", (scanResult) => {
        console.log(scanResult)
        alert(scanResult.barcodes[0].data);
      });
    });
  }
};

export { initScanner };
