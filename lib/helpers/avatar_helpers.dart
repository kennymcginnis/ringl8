import 'package:avataaar_image/avataaar_image.dart';

class AvatarHelpers {
  /// Converts from the website, for example:
  /// https://getavataaars.com/?accessoriesType=Prescription01&clotheColor=PastelYellow&clotheType=Hoodie&eyeType=Side&eyebrowType=DefaultNatural&hairColor=Blonde&mouthType=Smile&skinColor=Light&topType=LongHairCurvy
  /// to an Avataaar
  /// should have a ? before the parts, with each part containing a &key=value
  static Avataaar avatarFromAvataaarsUrl(String url) {
    String enumToJson<T>(T value) => value != null ? value.toString().split('.')[1] : null;

    T enumFromJson<T>(List<T> values, String json) => json != null
        ? values.firstWhere((it) => enumToJson(it).toLowerCase() == json.toLowerCase(),
            orElse: () => null)
        : null;

    TopType topType;
    AccessoriesType accessoriesType;
    HatColor hatColor;
    HairColor hairColor;
    FacialHairType facialHairType;
    FacialHairColor facialHairColor;

    ClotheType clotheType;
    ClotheColor clotheColor;
    GraphicType graphicType;

    EyeType eyeType;

    EyebrowType eyebrowType;

    MouthType mouthType;

    SkinColor skinColor;

    AvatarStyle avatarStyle;

    String params = url.substring(url.indexOf('?') +1);
    List<String> parts = params.split('&');

    if (parts.isNotEmpty) {
      parts.forEach((part) {
        List<String> keyValue = part.split('=');
        if (keyValue.length == 2) {
          var key = keyValue[0];
          var value = keyValue[1];
          switch (key) {
            case 'topType':
              topType = enumFromJson(TopType.values, value);
              break;
            case 'accessoriesType':
              accessoriesType = enumFromJson(AccessoriesType.values, value);
              break;
            case 'hatColor':
              hatColor = enumFromJson(HatColor.values, value);
              break;
            case 'hairColor':
              hairColor = enumFromJson(HairColor.values, value);
              break;
            case 'facialHairType':
              facialHairType = enumFromJson(FacialHairType.values, value);
              break;
            case 'facialHairColor':
              facialHairColor = enumFromJson(FacialHairColor.values, value);
              break;
            case 'clotheType':
              clotheType = enumFromJson(ClotheType.values, value);
              break;
            case 'clotheColor':
              clotheColor = enumFromJson(ClotheColor.values, value);
              break;
            case 'graphicType':
              graphicType = enumFromJson(GraphicType.values, value);
              break;
            case 'eyeType':
              eyeType = enumFromJson(EyeType.values, value);
              break;
            case 'eyebrowType':
              eyebrowType = enumFromJson(EyebrowType.values, value);
              break;
            case 'mouthType':
              mouthType = enumFromJson(MouthType.values, value);
              break;
            case 'skinColor':
              skinColor = enumFromJson(SkinColor.values, value);
              break;
            case 'avatarStyle':
              avatarStyle = enumFromJson(AvatarStyle.values, value);
              break;
            default:
              print('error mapping url');
          }
        }
      });
    }

    var avataaar = Avataaar(
      top: Top(
        topType: topType,
        accessoriesType: accessoriesType,
        hatColor: hatColor,
        hairColor: hairColor,
        facialHair: FacialHair(
          facialHairType: facialHairType,
          facialHairColor: facialHairColor,
        ),
      ),
      clothes: Clothes(
        clotheType: clotheType,
        clotheColor: clotheColor,
        graphicType: graphicType,
      ),
      eyes: Eyes(eyeType: eyeType),
      eyebrow: Eyebrow(eyebrowType: eyebrowType),
      mouth: Mouth(mouthType: mouthType),
      skin: Skin(skinColor: skinColor),
      style: Style(avatarStyle: AvatarStyle.Circle), // setting all to 'circle'
    );
    return avataaar;
  }
}
