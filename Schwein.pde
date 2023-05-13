class Schwein extends Hittable {
  Schwein() {
    super.setFill(0, 255, 0);
    super.setSize(20);
    super.attachImage(pigTexture);
  }
}
