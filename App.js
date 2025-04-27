import React, { useState, useEffect } from 'react';
import { StyleSheet, SafeAreaView, StatusBar, View, Text, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
// import BarcodeScannerScreen from './BarcodeScannerScreen';
// import ProductDetailsScreen from './ProductDetailsScreen';
import ProductDetailsScreen from './Screens/Product/ProductDetailSrc';
import BarcodeScannerScreen from './Screens/ScanScreen';

export default function App() {
  const [scannedBarcode, setScannedBarcode] = useState(null);
  const [screenState, setScreenState] = useState('scanner'); // 'scanner', 'product', 'error'
  const [errorMessage, setErrorMessage] = useState(null);
  
  // For testing: uncomment to go directly to product screen with test barcode
  // useEffect(() => {
  //   setScannedBarcode('0000101209159');
  //   setScreenState('product');
  // }, []);

  const handleScanSuccess = (barcodeData) => {
    console.log('Barcode scanned:', barcodeData);
    setScannedBarcode(barcodeData);
    setScreenState('product');
  };

  const handleBackToScanner = () => {
    setScannedBarcode(null);
    setScreenState('scanner');
    setErrorMessage(null);
  };

  const handleError = (message) => {
    setErrorMessage(message);
    setScreenState('error');
  };

  // Render based on screen state
  if (screenState === 'scanner') {
    return <BarcodeScannerScreen onScanSuccess={handleScanSuccess} />;
  }
  
  if (screenState === 'error') {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.errorContainer}>
          <Ionicons name="alert-circle-outline" size={60} color="#E74C3C" />
          <Text style={styles.errorText}>{errorMessage || 'An error occurred'}</Text>
          <TouchableOpacity style={styles.button} onPress={handleBackToScanner}>
            <Text style={styles.buttonText}>Scan Again</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }
  
  if (screenState === 'product' && scannedBarcode) {
    return (
      <ProductDetailsScreen 
        barcode={scannedBarcode} 
        navigation={{ goBack: handleBackToScanner }}
      />
    );
  }
  
  // Fallback (shouldn't happen normally)
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>Something went wrong</Text>
        <TouchableOpacity style={styles.button} onPress={handleBackToScanner}>
          <Text style={styles.buttonText}>Go Back</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  errorText: {
    fontSize: 16,
    color: '#E74C3C',
    textAlign: 'center',
    marginTop: 15,
    marginBottom: 20,
  },
  button: {
    backgroundColor: '#4CAF50',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 20,
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  },
});