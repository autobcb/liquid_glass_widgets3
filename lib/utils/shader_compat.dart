import 'dart:ui';

bool? _supportsFilterQualityOnImageSampler;

void setImageSamplerCompat(
  FragmentShader shader,
  int index,
  Image image, {
  FilterQuality filterQuality = FilterQuality.medium,
}) {
  final cached = _supportsFilterQualityOnImageSampler;
  if (cached == true) {
    (shader as dynamic).setImageSampler(index, image, filterQuality: filterQuality);
    return;
  }
  if (cached == false) {
    shader.setImageSampler(index, image);
    return;
  }
  try {
    (shader as dynamic).setImageSampler(index, image, filterQuality: filterQuality);
    _supportsFilterQualityOnImageSampler = true;
  } catch (_) {
    shader.setImageSampler(index, image);
    _supportsFilterQualityOnImageSampler = false;
  }
}
