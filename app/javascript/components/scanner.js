import * as ScanditSDK from "scandit-sdk";

const initScanner = () => {

  ScanditSDK.configure("AZe/JDPaLHLHIofYlxfs5Xg7yF3mLmYtu1z4Vz4nVNXFPn1gthhSyvppHJJ3anUjog1W/MI1qlAcV5O8/lPNiYdlZ8sRX/bJs1vKMqhaUr23GSfyCjQ6ioJDolD3JdbQA5d8Ju7MkrD4uebTpCQmJiTO+j+fTPZ8ucaQMPjGUIfXoJb/IDtHXnI5aIzTMXmujus6+Uah+Ijtc9hrd0gN/sjRIYqqkYQPH0VvNlokyDsonatxO0V+FLEJYF/R6Gc/2OAa/LrOM55Mm12GKPWMMzmGRkLH5PYJIfUdD2WPu9mv6QFLD1Lal7auT6uw3Mbh0A0LRWVeL1/X2IgaCZfEEecaiZbZxQKefw5A6VdndDH9UNll1yD2T1uKjw0dgEa0f7Nf93IATrUntLHE4yFtOB8N6F370r7hKsNW7OubLcfxyyJlaFCB24w4KbDO/7c2PDhCPwwSbJOo/Co8ElwwP/04NSW9G1RbBhy/MK1dDfcrccOXejtSwxR1Eb+M4klYfvubtojDCXynKLK4Sdt33OYZQ4/im18pGJ6Kh2zY+Pl71scQUCXGe8zli5xzzBbIM875IAsbRVyMqxgwZjCs3UZFMnfcVYY1BHle81HTRiokk55cvk9PN1zQgNVgFV3bnvgX34ZN7zkCLN3K1ZKe5vZYuar0KQbduxrs2509ru5lgMZgZ8l0vFltR3GKujE1PIQqVXPACcPTwuybffqbWGOPTQ1g6RvcW9whzXyCj4HyERm1IdtedDg5YC4dCrvLrXheaPSEa1Q+xyVqX3f/H7YhEMFUhWfZv51J7jIN", {
    engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk@5.x/build/",
  })
  .then(() => {
    return ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
      playSoundOnScan: false,
      vibrateOnScan: false,
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
      // console.log(scanResult)
      // alert(scanResult.barcodes[0].data);
      console.log(scanResult.barcodes[0].data)

    });
  });
};

export { initScanner };
