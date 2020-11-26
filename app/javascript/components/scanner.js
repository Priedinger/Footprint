import * as ScanditSDK from "scandit-sdk";

const initScanner = () => {

  ScanditSDK.configure("AdSvZSLaPRh+EY4C+wBw7bMAwyuYLIgrfEnfrLIgyD2mCF4YlS1h+M9xmTdOcea7vnXdAvgWwfqzfgH0X2fClfZoFXstVSrVgw8c9v1cKFZ/deWWSG2BMaBcBenLSiHoJkih0A1DbJ6sbPHzmSnQ6Ep/TjMdSHg4sHCYRYpuORB3SuSZS0P462YqZEMhVdOpFm8hFOhYR9O8XN0sZV8J6fZee71VZ7F0mladX4xizutcdZDz1kkyRfRjpChDY6bGanx0rypdf/0mW9qtxUI3Ob0kSlfXeehQPUdCDdRrM8XZfsMNLVtQTZpDRDr2bhYtMXkT8D16/2CYQqRA2GHlGipaDDGvTBTtXnsGqK97iEqUXWQAB2T5GP1yjJihSKr7MD/KmzxLQGlODxPtkEN0Bn9LyE2lesy4WWq/9q1vLqNNRohA5FnOecp1nkfqZzc1yVlP5zl4cn6GCm9ON38xzbpjFpD5YKRVgQiVdx951Vd1YEiGKWxNc0dlx+8hbFQR4iMyGW8PD5vrBpqVlioGaqotWXtIIg7pgNUQm27xrIB1TrRHD255p9Q7k7nv6EieZbEcJ0yDphn3PA+3dG2EGoKHZQKQ+H7JcPbEWdOkqURgA8MKJCNTcfe82D99W+bvicp/hOQASvaQcvb8CtDntlB2T+fxGGxkQhu04ZXJ9LXxiQdge77oqPFFmlYS+xJW6oAUpma/qB9KF2XVC3v49GN7UzGP1CfeZH9wNuFpKJ+73S7Zb/+lb4TUtesXUvLdddYoDbYz33XFxX19Fz/LpmccHP5tc7zw2uYrvttSWdYhds8w9NAzuBrP+Aws7vP4O+4kMr/Qs6ef1wOeixBOxWwNWjECTO+9oG9eeRsI49ZyvvImKrfL1q2tCWHVVr47Z4Vo4rY+k6XXBoGczCxe0NvGsYcVL580E/mh/zP4Np2R5UYQ0EhRqQqu+5T1/FjBDfq9QE8yusfR9tG5tUkbNDY+REJZnC5fwUfdXOrD5NOgeoY4mQp/qzvuo1/luaoT2/kI8+mpvsxbp06veigDEDdxUyMTK6iSzP11V1RlLtmJPL0B6nKPd4VLH7MngYDiwjuxU6hlqNjWaKNNl51FWDP00LNWm0sbWUOp6Hhqj1e2sMrgaJELHSim0y1xPKIZl3U1sFgvuZ7dil/7XezNCVjzWGIHIRPL6zztFIrR457r9so0JM2rf+YGp0CLsCI=", {
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
};

export { initScanner };
