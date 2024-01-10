Map<String, int> iconMap = {
  'notifications': 0xE000,
  'pencil': 0xE001,
  'brush': 0xE002,
  'wifi': 0xE004,
  'chat': 0xE005,
  'notifications_off': 0xE008,
  'notifications_active': 0xE009,
  'send': 0xE00A,
  'person': 0xE00B,
  'people': 0xE00C,
  'no_show': 0xE00D,
  'person_status': 0xE00E,
  'chart': 0xE013,
  'restore': 0xE01F,
  'undo': 0xE02A,
  'update': 0xE02B,
  'refresh': 0xE02C,
  'chevron_up': 0xE02D,
  'chevron_right': 0xE02E,
  'chevron_down': 0xE02F,
  'chevron_left': 0xE03A,
  'arrow_up': 0xE03B,
  'arrow_right': 0xE03C,
  'arrow_down': 0xE03D,
  'arrow_left': 0xE03E,
  'delete': 0xE03F,
  'volume': 0xE04C,
  'volume_low': 0xE04D,
  'volume_medium': 0xE04E,
  'volume_up': 0xE04F,
  'volume_off': 0xE05A,
  'hearing': 0xE05B,
  'mic': 0xE05C,
  'mic_off': 0xE05D,
  'recording': 0xE05E,
  'no_audio': 0xE05F,
  'refresh_audio': 0xE06A,
  'load_audio': 0xE06B,
  'play_arrow': 0xE06D,
  'pause': 0xE06E,
  'stop': 0xE06F,
  'skip_next': 0xE07A,
  'skip_previous': 0xE07B,
  'record': 0xE07C,
  'previous': 0xE08C,
  'next': 0xE08D,
  'cloud': 0xE097,
  'upload': 0xE098,
  'up_balls': 0xE099,
  'download': 0xE09A,
  'rearrange': 0xE09B,
  'slider': 0xE09D,
  'list': 0xE09E,
  'sidebar_close': 0xE09F,
  'sidebar_open': 0xE0A0,
  'open_menu': 0xE0A1,
  'close_menu': 0xE0A2,
  'down_menu': 0xE0A3,
  'up_menu': 0xE0A4,
  'launch': 0xE0A5,
  'exit_to_app': 0xE0A6,
  'menu': 0xE0A7,
  'more_vert': 0xE0A8,
  'more_horiz': 0xE0A9,
  'cell_phone': 0xE0B8,
  'phone': 0xE0B9,
  'home': 0xE0BA,
  'language': 0xE0BB,
  'url': 0xE0BC,
  'lang': 0xE0BD,
  'lang_help': 0xE0BE,
  'map': 0xE0BF,
  'country': 0xE0C0,
  'notification': 0xE0C8,
  'flag': 0xE0C9,
  'place': 0xE0CA,
  'mail': 0xE0CB,
  'award': 0xE0E7,
  'trophy': 0xE0E8,
  'shopping_cart': 0xE0F5,
  'bet': 0xE0F6,
  'add_balance': 0xE0F7,
  'payment': 0xE0F8,
  'bill': 0xE0F9,
  'deal': 0xE0FA,
  'gift': 0xE0FB,
  'time': 0xE0FC,
  'chronometer': 0xE0FD,
  'time_record': 0xE0FE,
  'folder': 0xE111,
  'folder_open': 0xE112,
  'folder_add': 0xE113,
  'folder_special': 0xE114,
  'folder_delete': 0xE115,
  'page': 0xE117,
  'book': 0xE118,
  'test': 0xE119,
  'flash_cards': 0xE11A,
  'pdf': 0xE124,
  'doc': 0xE125,
  'jpg': 0xE126,
  'png': 0xE127,
  'chevron_tr': 0xE130,
  'chevron_dr': 0xE131,
  'chevron_dl': 0xE132,
  'chevron_tl': 0xE133,
  'check': 0xE134,
  'check_outline': 0xE135,
  'checked': 0xE136,
  'unchecked': 0xE137,
  'rb_checked': 0xE139,
  'rb_unchecked': 0xE13A,
  'hot': 0xE165,
  'cold': 0xE166,
  'hot_cold': 0xE167,
  'delta': 0xE168,
  'delta_cold': 0xE169,
  'delta_hot': 0xE16A,
  'sum': 0xE16B,
  'sum_hot': 0xE16C,
  'sum_cold': 0xE16D,
  'face_id': 0xE177,
  'ar_horiz': 0xE181,
  'ar_vert': 0xE182,
  'parking': 0xE19F,
  'bike': 0xE1A0,
  'walk': 0xE1A1,
  'girl': 0xE1A2,
  'boy': 0xE1A3,
  'disabled': 0xE1A4,
  'photo_id': 0xE1A5,
  'politician': 0xE1CC,
  'bull': 0xE1CD,
  'cow': 0xE1CE,
  'verified': 0xE1E1,
  'verified_user': 0xE1E2,
  'lock': 0xE1E3,
  'lock_open': 0xE1E4,
  'advertising': 0xE1FA,
  'no_advertising': 0xE1FB,
  'video': 0xE1FC,
  'question_answer': 0xE201,
  'info': 0xE202,
  'help': 0xE203,
  'error': 0xE204,
  'visibility': 0xE205,
  'visibility_off': 0xE206,
  'thumb_up': 0xE207,
  'thumb_down': 0xE208,
  'favorite_border': 0xE209,
  'favorite': 0xE20A,
  'favorite_dislike': 0xE20B,
  'share': 0xE20C,
  'bookmark': 0xE20D,
  'star_border': 0xE20E,
  'star_half': 0xE20F,
  'star': 0xE210,
  'rate': 0xE211,
  'ticket': 0xE212,
  'game': 0xE213,
  'lotto': 0xE214,
  'cabala': 0xE215,
  'clover': 0xE216,
  'sad_face': 0xE22D,
  'happy_face': 0xE22E,
  'dictation': 0xE22F,
  'oral': 0xE230,
  'event_available': 0xE231,
  'upcoming': 0xE232,
  'past': 0xE233,
  'event': 0xE234,
  'no_event': 0xE235,
  'month': 0xE236,
  'dashboard': 0xE23A,
  'campaign': 0xE23B,
  'push_pin': 0xE244,
  'search': 0xE245,
  'search_page': 0xE246,
  'search_person': 0xE247,
  'search_number': 0xE248,
  'camera': 0xE254,
  'no_image': 0xE255,
  'images': 0xE256,
  'remove': 0xE257,
  'remove_circle': 0xE258,
  'add': 0xE259,
  'add_circle': 0xE25A,
  'close': 0xE25B,
  'cancel': 0xE25C,
  'filter': 0xE25D,
  'edit': 0xE25E,
  'settings': 0xE25F,
  'save': 0xE260,
  'add_square': 0xE262,
  'remove_square': 0xE263,
  'television': 0xE26B,
  'store': 0xE26C,
  'drink': 0xE26D,
  'bulb_on': 0xE27A,
  'bulb': 0xE27B,
  'cashier': 0xE27C,
  'afternoon': 0xE285,
  'evening': 0xE286,
  'full_square': 0xE287,
  'full_dot': 0xE288,
  'brightness_1': 0xE289,
  'brightness_2': 0xE28A,
  'brightness_3': 0xE28B,
  'brightness_4': 0xE28C,
  'brightness_5': 0xE28D,
  'brightness_6': 0xE28E,
  'brightness_7': 0xE28F,
  'facebook': 0xE291,
  'twitter': 0xE292,
  'youtube': 0xE293,
  'instagram': 0xE294,
  'linkedin': 0xE295,
  'github': 0xE2A0,
  'gitlab': 0xE2A1,
  'npm': 0xE2A2,
  'apple_logo': 0xE2A3,
  'facebook_logo': 0xE2A4,
  'google_logo': 0xE2A5,
  'whatsapp_logo': 0xE2A6,
  'logo': 0xE2AF,
};
