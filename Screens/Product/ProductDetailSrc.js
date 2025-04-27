import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Image,
  TouchableOpacity,
  ActivityIndicator,
  SafeAreaView,
  StatusBar,
  Platform,
} from 'react-native';
import { Ionicons, MaterialCommunityIcons, FontAwesome5 } from '@expo/vector-icons';

const ProductDetailsScreen = ({ route, navigation, barcode }) => {
  // If using navigation, we'd get the barcode from route.params
  // For direct usage, we accept it as a prop
  const barcodeValue = route?.params?.barcode || barcode;
  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [product, setProduct] = useState(null);
  const [activeTab, setActiveTab] = useState('summary');

  useEffect(() => {
    if (barcodeValue) {
      fetchProductData(barcodeValue);
    }
  }, [barcodeValue]);

  const fetchProductData = async (code) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`https://foodproductsapp-702913670684.us-east4.run.app/query?field=code&value=0000101209159`);
      if (!response.ok) {
        throw new Error('Product not found');
      }
      const data = await response.json();
      setProduct(data);
    } catch (err) {
      setError('Could not find product information');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  // Helper function to get score color
  const getScoreColor = (score) => {
    if (!score) return '#CCCCCC';
    
    const normalizedScore = score.toLowerCase();
    switch (normalizedScore) {
      case 'a':
        return '#038141';
      case 'b':
        return '#85BB2F';
      case 'c':
        return '#FECB02';
      case 'd':
        return '#EE8100';
      case 'e':
        return '#E63E11';
      default:
        return '#CCCCCC';
    }
  };

  // Helper function to get level color
  const getLevelColor = (level) => {
    switch (level) {
      case 'high':
        return '#E74C3C';
      case 'moderate':
        return '#F39C12';
      case 'low':
        return '#2ECC71';
      default:
        return '#CCCCCC';
    }
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#4CAF50" />
        <Text style={styles.loadingText}>Loading product information...</Text>
      </View>
    );
  }

  if (error || !product) {
    return (
      <View style={styles.errorContainer}>
        <Ionicons name="alert-circle-outline" size={60} color="#E74C3C" />
        <Text style={styles.errorText}>{error || 'Product not found'}</Text>
        <TouchableOpacity 
          style={styles.button}
          onPress={() => navigation?.goBack()}
        >
          <Text style={styles.buttonText}>Go Back</Text>
        </TouchableOpacity>
      </View>
    );
  }

  // Extract the nutriscore grade
  const nutriscoreGrade = product.nutriscore_data?.grade || 'n/a';

  // Format a nutrient value with its unit
  const formatNutrient = (value, unit = '') => {
    if (value === undefined || value === null) return 'N/A';
    return `${value}${unit}`;
  };

  return (
    <SafeAreaView style={styles.safeArea}>
      <StatusBar barStyle="dark-content" backgroundColor="#FFFFFF" />
      
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton} 
          onPress={() => navigation?.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color="#333" />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>{product.brands || 'Product Details'}</Text>
      </View>
      
      <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
        {/* Product Basic Info */}
        <View style={styles.productHeader}>
          <View style={styles.productImageContainer}>
            {/* Product image placeholder */}
            <View style={styles.productImage}>
              <MaterialCommunityIcons name="food" size={50} color="#4CAF50" />
            </View>
          </View>
          
          <View style={styles.productInfo}>
            <Text style={styles.productName}>{product.product_name || 'Unknown Product'}</Text>
            <Text style={styles.productBrand}>{product.brands || 'Unknown Brand'}</Text>
            <Text style={styles.productQuantity}>{product.quantity || 'Unknown Quantity'}</Text>
            
            <View style={styles.scoreContainer}>
              <View style={styles.scoreItem}>
                <Text style={styles.scoreTitle}>NUTRI-SCORE</Text>
                <View style={styles.nutriscoreRow}>
                  {['a', 'b', 'c', 'd', 'e'].map((grade) => (
                    <View
                      key={grade}
                      style={[
                        styles.nutriscoreCircle,
                        {
                          backgroundColor: grade === nutriscoreGrade.toLowerCase() 
                            ? getScoreColor(grade) 
                            : '#EEEEEE',
                          width: grade === nutriscoreGrade.toLowerCase() ? 45 : 35,
                          height: grade === nutriscoreGrade.toLowerCase() ? 45 : 35,
                          zIndex: grade === nutriscoreGrade.toLowerCase() ? 2 : 1,
                        }
                      ]}
                    >
                      <Text
                        style={[
                          styles.nutriscoreText,
                          {
                            color: grade === nutriscoreGrade.toLowerCase() ? '#FFFFFF' : '#999999',
                            fontSize: grade === nutriscoreGrade.toLowerCase() ? 20 : 16,
                          }
                        ]}
                      >
                        {grade.toUpperCase()}
                      </Text>
                    </View>
                  ))}
                </View>
              </View>
            </View>
          </View>
        </View>
        
        {/* Tab Navigation */}
        <View style={styles.tabsContainer}>
          <TouchableOpacity 
            style={[styles.tab, activeTab === 'summary' && styles.activeTab]} 
            onPress={() => setActiveTab('summary')}
          >
            <Text style={[styles.tabText, activeTab === 'summary' && styles.activeTabText]}>Summary</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            style={[styles.tab, activeTab === 'nutrition' && styles.activeTab]} 
            onPress={() => setActiveTab('nutrition')}
          >
            <Text style={[styles.tabText, activeTab === 'nutrition' && styles.activeTabText]}>Nutrition</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            style={[styles.tab, activeTab === 'packaging' && styles.activeTab]} 
            onPress={() => setActiveTab('packaging')}
          >
            <Text style={[styles.tabText, activeTab === 'packaging' && styles.activeTabText]}>Packaging</Text>
          </TouchableOpacity>
        </View>
        
        {/* Tab Content */}
        {activeTab === 'summary' && (
          <View style={styles.tabContent}>
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Nutrition Quality</Text>
              <View style={styles.listContainer}>
                {/* Additives */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <MaterialCommunityIcons name="flask-outline" size={24} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Additives</Text>
                    <Text style={styles.listItemDescription}>Ingredients advantageous to avoid</Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: '#E74C3C' }
                  ]} />
                </View>
                
                {/* Sugar */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <MaterialCommunityIcons name="cube-outline" size={24} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Sugar</Text>
                    <Text style={styles.listItemValue}>
                      {formatNutrient(
                        product.nutriments?.sugars_100g || product.nutriments?.sugars,
                        product.nutriments?.sugars_unit || 'g'
                      )}
                    </Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: product.nutrient_levels?.sugars ? 
                      getLevelColor(product.nutrient_levels.sugars) : '#CCCCCC' }
                  ]} />
                </View>
                
                {/* Calories */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <Ionicons name="flame-outline" size={24} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Calories</Text>
                    <Text style={styles.listItemDescription}>A bit too energetic</Text>
                    <Text style={styles.listItemValue}>
                      {formatNutrient(
                        product.nutriments?.['energy-kcal_100g'] || 
                        product.nutriments?.['energy-kcal'] || 
                        product.nutriments?.energy,
                        'Cal'
                      )}
                    </Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: '#E74C3C' }
                  ]} />
                </View>
                
                {/* Sodium */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <FontAwesome5 name="drumstick-bite" size={22} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Sodium</Text>
                    <Text style={styles.listItemValue}>
                      {formatNutrient(
                        product.nutriments?.salt_100g || product.nutriments?.salt,
                        product.nutriments?.salt_unit || 'g'
                      )}
                    </Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: product.nutrient_levels?.salt ? 
                      getLevelColor(product.nutrient_levels.salt) : '#CCCCCC' }
                  ]} />
                </View>
              </View>
            </View>
            
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Positives</Text>
              <View style={styles.listContainer}>
                {/* Fiber */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <MaterialCommunityIcons name="barley" size={24} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Fiber</Text>
                    <Text style={styles.listItemDescription}>Good amount of fiber</Text>
                    <Text style={styles.listItemValue}>
                      {formatNutrient(
                        product.nutriments?.fiber_100g || product.nutriments?.fiber || '3.6',
                        product.nutriments?.fiber_unit || 'g'
                      )}
                    </Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: '#2ECC71' }
                  ]} />
                </View>
                
                {/* Protein */}
                <View style={styles.listItem}>
                  <View style={styles.iconContainer}>
                    <MaterialCommunityIcons name="fish" size={24} color="#555" />
                  </View>
                  <View style={styles.listItemContent}>
                    <Text style={styles.listItemTitle}>Protein</Text>
                    <Text style={styles.listItemDescription}>Good protein content</Text>
                    <Text style={styles.listItemValue}>
                      {formatNutrient(
                        product.nutriments?.proteins_100g || product.nutriments?.proteins,
                        product.nutriments?.proteins_unit || 'g'
                      )}
                    </Text>
                  </View>
                  <View style={[
                    styles.indicatorCircle, 
                    { backgroundColor: '#2ECC71' }
                  ]} />
                </View>
              </View>
            </View>
          </View>
        )}
        
        {activeTab === 'nutrition' && (
          <View style={styles.tabContent}>
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Nutritional Information</Text>
              <Text style={styles.sectionSubtitle}>per 100g</Text>
              
              <View style={styles.nutritionTable}>
                {/* Energy */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Energy</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.['energy-kcal_100g'] || 
                      product.nutriments?.['energy-kcal'] || 
                      product.nutriments?.energy,
                      product.nutriments?.['energy-kcal_unit'] || 
                      product.nutriments?.energy_unit || 'kcal'
                    )}
                  </Text>
                </View>
                
                {/* Fat */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Fat</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.fat_100g || product.nutriments?.fat,
                      product.nutriments?.fat_unit || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Saturated Fat */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionSubLabel}>of which saturated</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.['saturated-fat_100g'] || 
                      product.nutriments?.['saturated-fat'],
                      product.nutriments?.['saturated-fat_unit'] || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Carbohydrates */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Carbohydrates</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.carbohydrates_100g || 
                      product.nutriments?.carbohydrates,
                      product.nutriments?.carbohydrates_unit || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Sugars */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionSubLabel}>of which sugars</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.sugars_100g || product.nutriments?.sugars,
                      product.nutriments?.sugars_unit || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Proteins */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Protein</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.proteins_100g || product.nutriments?.proteins,
                      product.nutriments?.proteins_unit || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Salt */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Salt</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.salt_100g || product.nutriments?.salt,
                      product.nutriments?.salt_unit || 'g'
                    )}
                  </Text>
                </View>
                
                {/* Fiber */}
                <View style={styles.nutritionRow}>
                  <Text style={styles.nutritionLabel}>Fiber</Text>
                  <Text style={styles.nutritionValue}>
                    {formatNutrient(
                      product.nutriments?.fiber_100g || product.nutriments?.fiber || 'N/A',
                      product.nutriments?.fiber_unit || 'g'
                    )}
                  </Text>
                </View>
              </View>
            </View>
          </View>
        )}
        
        {activeTab === 'packaging' && (
          <View style={styles.tabContent}>
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Packaging Information</Text>
              
              {product.packagings && product.packagings.length > 0 ? (
                <View style={styles.packagingList}>
                  {product.packagings.map((item, index) => (
                    <View key={index} style={styles.packagingItem}>
                      <View style={styles.packagingIcon}>
                        {item.material === 'en:glass' && (
                          <MaterialCommunityIcons name="bottle-wine" size={24} color="#5DADE2" />
                        )}
                        {item.material === 'en:metal' && (
                          <MaterialCommunityIcons name="metal" size={24} color="#7F8C8D" />
                        )}
                        {item.material === 'en:plastic' && (
                          <MaterialCommunityIcons name="bottle-soda" size={24} color="#C0392B" />
                        )}
                        {item.material === 'en:paper' && (
                          <MaterialCommunityIcons name="file" size={24} color="#F39C12" />
                        )}
                        {!['en:glass', 'en:metal', 'en:plastic', 'en:paper'].includes(item.material) && (
                          <MaterialCommunityIcons name="package-variant" size={24} color="#9B59B6" />
                        )}
                      </View>
                      
                      <View style={styles.packagingDetails}>
                        <Text style={styles.packagingTitle}>
                          {item.material?.replace('en:', '').replace(/-/g, ' ')} 
                          {item.shape ? ` ${item.shape.replace('en:', '').replace(/-/g, ' ')}` : ''}
                        </Text>
                        
                        {item.recycling && (
                          <View style={styles.recyclingInfo}>
                            <MaterialCommunityIcons name="recycle" size={16} color="#4CAF50" />
                            <Text style={styles.recyclingText}>
                              {item.recycling === 'en:recycle-in-sorting-bin' 
                                ? 'Recyclable' 
                                : item.recycling.replace('en:', '').replace(/-/g, ' ')}
                            </Text>
                          </View>
                        )}
                      </View>
                    </View>
                  ))}
                </View>
              ) : (
                <Text style={styles.noDataText}>No packaging information available</Text>
              )}
            </View>
          </View>
        )}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#FFFFFF',
    paddingTop: Platform.OS === 'android' ? StatusBar.currentHeight : 0,
  },
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  loadingText: {
    marginTop: 15,
    fontSize: 16,
    color: '#666666',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    padding: 20,
  },
  errorText: {
    marginTop: 15,
    marginBottom: 20,
    fontSize: 16,
    color: '#E74C3C',
    textAlign: 'center',
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
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 15,
    paddingVertical: 12,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  backButton: {
    padding: 5,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 15,
    color: '#333333',
  },
  productHeader: {
    flexDirection: 'row',
    padding: 15,
    backgroundColor: '#FFFFFF',
  },
  productImageContainer: {
    marginRight: 15,
  },
  productImage: {
    width: 80,
    height: 80,
    borderRadius: 10,
    backgroundColor: '#F0F0F0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  productInfo: {
    flex: 1,
  },
  productName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 4,
  },
  productBrand: {
    fontSize: 16,
    color: '#666666',
    marginBottom: 4,
  },
  productQuantity: {
    fontSize: 14,
    color: '#888888',
    marginBottom: 10,
  },
  scoreContainer: {
    marginTop: 5,
  },
  scoreItem: {
    alignItems: 'flex-start',
  },
  scoreTitle: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#666666',
    marginBottom: 5,
  },
  nutriscoreRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  nutriscoreCircle: {
    width: 35,
    height: 35,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginHorizontal: -3,
  },
  nutriscoreText: {
    fontWeight: 'bold',
    fontSize: 16,
  },
  tabsContainer: {
    flexDirection: 'row',
    backgroundColor: '#FFFFFF',
    marginTop: 10,
  },
  tab: {
    flex: 1,
    paddingVertical: 15,
    alignItems: 'center',
  },
  tabText: {
    fontSize: 14,
    color: '#666666',
  },
  activeTab: {
    borderBottomWidth: 3,
    borderBottomColor: '#4CAF50',
  },
  activeTabText: {
    color: '#4CAF50',
    fontWeight: 'bold',
  },
  tabContent: {
    backgroundColor: '#F5F5F5',
    paddingBottom: 20,
  },
  section: {
    backgroundColor: '#FFFFFF',
    marginTop: 10,
    padding: 15,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333333',
    marginBottom: 5,
  },
  sectionSubtitle: {
    fontSize: 14,
    color: '#888888',
    marginBottom: 15,
  },
  listContainer: {
    marginTop: 10,
  },
  listItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  iconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 15,
  },
  listItemContent: {
    flex: 1,
  },
  listItemTitle: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333333',
  },
  listItemDescription: {
    fontSize: 14,
    color: '#888888',
  },
  listItemValue: {
    fontSize: 14,
    color: '#666666',
    marginTop: 2,
  },
  indicatorCircle: {
    width: 12,
    height: 12,
    borderRadius: 6,
  },
  nutritionTable: {
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    overflow: 'hidden',
  },
  nutritionRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingHorizontal: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  nutritionLabel: {
    fontSize: 16,
    color: '#333333',
  },
  nutritionSubLabel: {
    fontSize: 16,
    color: '#666666',
    paddingLeft: 20,
  },
  nutritionValue: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333333',
  },
  packagingList: {
    marginTop: 10,
  },
  packagingItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  packagingIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 15,
  },
  packagingDetails: {
    flex: 1,
  },
  packagingTitle: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333333',
    textTransform: 'capitalize',
  },
  recyclingInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 5,
  },
  recyclingText: {
    fontSize: 14,
    color: '#4CAF50',
    marginLeft: 5,
  },
  noDataText: {
    fontSize: 16,
    color: '#888888',
    textAlign: 'center',
    marginTop: 20,
  },
});

export default ProductDetailsScreen;