import React, { useState, useEffect } from 'react';
import { StyleSheet, View, Text, TouchableOpacity, ActivityIndicator, SafeAreaView, StatusBar } from 'react-native';
import { CameraView, useCameraPermissions } from 'expo-camera';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';

const BarcodeScannerScreen = ({ onScanSuccess }) => {
  const [permission, requestPermission] = useCameraPermissions();
  const [scanning, setScanning] = useState(true);
  const [scannedBarcode, setScannedBarcode] = useState(null);

  useEffect(() => {
    if (!permission?.granted) {
      requestPermission();
    }
  }, [permission, requestPermission]);

  const handleBarCodeScanned = (scanningResult) => {
    if (!scanning) return;
    
    // Provide haptic feedback
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    
    // Get the type and data from the scanning result
    const { type, data } = scanningResult;
    
    // Set state and stop scanning
    setScannedBarcode({ type, data });
    setScanning(false);
    
    // If callback provided, call it
    if (onScanSuccess) {
      onScanSuccess(data);
    }
    
    console.log(`Bar code with type ${type} and data ${data} has been scanned!`);
  };

  const resetScanner = () => {
    setScannedBarcode(null);
    setScanning(true);
  };

  if (permission === null) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" color="#4CAF50" />
        <Text style={styles.permissionText}>Requesting camera permission...</Text>
      </View>
    );
  }

  if (permission?.granted === false) {
    return (
      <View style={styles.container}>
        <Ionicons name="camera-off-outline" size={60} color="#E74C3C" />
        <Text style={styles.permissionText}>No access to camera</Text>
        <TouchableOpacity style={styles.button} onPress={requestPermission}>
          <Text style={styles.buttonText}>Grant Permission</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor="#000000" />
      
      <CameraView
        style={styles.camera}
        onBarcodeScanned={scanning ? handleBarCodeScanned : undefined}
        barcodeScannerSettings={{
          barcodeTypes: [
             'aztec',
             'ean13',
             'ean8',
             'qr',
             'pdf417',
             'upc_e',
             'datamatrix',
             'code39',
             'code93',
             'itf14',
            'codabar',
            'code128',
             'upc_a'
          ],
        }}
        facing="back"
      >
        <View style={styles.overlay}>
          <View style={styles.header}>
            <Text style={styles.headerText}>Scan Product Barcode</Text>
          </View>

          <View style={styles.scanArea}>
            <View style={styles.scanFrame} />
            <Text style={styles.instructionText}>
              Position the barcode within the frame
            </Text>
          </View>

          {scannedBarcode && (
            <View style={styles.resultContainer}>
              <Text style={styles.resultText}>
                Barcode detected: {scannedBarcode.data}
              </Text>
              <View style={styles.buttonRow}>
                <TouchableOpacity style={styles.button} onPress={resetScanner}>
                  <Text style={styles.buttonText}>Scan Again</Text>
                </TouchableOpacity>
                
                <TouchableOpacity 
                  style={[styles.button, styles.primaryButton]} 
                  onPress={() => {
                    // Here you would navigate to product details screen
                    // passing the barcode data
                    alert(`Proceed with barcode: ${scannedBarcode.data}`);
                  }}
                >
                  <Text style={styles.buttonText}>Continue</Text>
                </TouchableOpacity>
              </View>
            </View>
          )}
        </View>
      </CameraView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000000',
  },
  camera: {
    flex: 1,
  },
  overlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.4)',
    justifyContent: 'space-between',
  },
  header: {
    padding: 20,
    alignItems: 'center',
  },
  headerText: {
    color: '#FFFFFF',
    fontSize: 20,
    fontWeight: 'bold',
  },
  scanArea: {
    alignItems: 'center',
  },
  scanFrame: {
    width: 250,
    height: 250,
    borderWidth: 2,
    borderColor: '#4CAF50',
    borderRadius: 15,
    backgroundColor: 'transparent',
  },
  instructionText: {
    color: '#FFFFFF',
    marginTop: 20,
    fontSize: 16,
    textAlign: 'center',
    paddingHorizontal: 40,
  },
  resultContainer: {
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    padding: 20,
    margin: 20,
    borderRadius: 10,
    alignItems: 'center',
  },
  resultText: {
    color: '#FFFFFF',
    fontSize: 16,
    marginBottom: 15,
    textAlign: 'center',
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    width: '100%',
  },
  button: {
    backgroundColor: '#444444',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 25,
    minWidth: 120,
    alignItems: 'center',
  },
  primaryButton: {
    backgroundColor: '#4CAF50',
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  },
  permissionText: {
    fontSize: 16,
    color: '#FFFFFF',
    marginTop: 15,
    textAlign: 'center',
    paddingHorizontal: 40,
  },
});

export default BarcodeScannerScreen;