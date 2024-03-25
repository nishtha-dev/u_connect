class ImageUtils {
  static String getImageExtension(String imageUrl) {
    return imageUrl.split('?').first.split('.').last.toLowerCase();
  }
}
