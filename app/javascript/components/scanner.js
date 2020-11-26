import * as ScanditSDK from "scandit-sdk";

const initScanner = () => {

    // utilisez cette ligne pour le local
    // ScanditSDK.configure("AZe/JDPaLHLHIofYlxfs5Xg7yF3mLmYtu1z4Vz4nVNXFPn1gthhSyvppHJJ3anUjog1W/MI1qlAcV5O8/lPNiYdlZ8sRX/bJs1vKMqhaUr23GSfyCjQ6ioJDolD3JdbQA5d8Ju7MkrD4uebTpCQmJiTO+j+fTPZ8ucaQMPjGUIfXoJb/IDtHXnI5aIzTMXmujus6+Uah+Ijtc9hrd0gN/sjRIYqqkYQPH0VvNlokyDsonatxO0V+FLEJYF/R6Gc/2OAa/LrOM55Mm12GKPWMMzmGRkLH5PYJIfUdD2WPu9mv6QFLD1Lal7auT6uw3Mbh0A0LRWVeL1/X2IgaCZfEEecaiZbZxQKefw5A6VdndDH9UNll1yD2T1uKjw0dgEa0f7Nf93IATrUntLHE4yFtOB8N6F370r7hKsNW7OubLcfxyyJlaFCB24w4KbDO/7c2PDhCPwwSbJOo/Co8ElwwP/04NSW9G1RbBhy/MK1dDfcrccOXejtSwxR1Eb+M4klYfvubtojDCXynKLK4Sdt33OYZQ4/im18pGJ6Kh2zY+Pl71scQUCXGe8zli5xzzBbIM875IAsbRVyMqxgwZjCs3UZFMnfcVYY1BHle81HTRiokk55cvk9PN1zQgNVgFV3bnvgX34ZN7zkCLN3K1ZKe5vZYuar0KQbduxrs2509ru5lgMZgZ8l0vFltR3GKujE1PIQqVXPACcPTwuybffqbWGOPTQ1g6RvcW9whzXyCj4HyERm1IdtedDg5YC4dCrvLrXheaPSEa1Q+xyVqX3f/H7YhEMFUhWfZv51J7jIN", {

    // utilisez cette ligne pour la production
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
