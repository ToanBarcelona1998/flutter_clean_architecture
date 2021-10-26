class Message{
  Message._();

  static const String login = 'Đăng nhập';

  //app title
  static const String appTitle= 'Article Application';
  //home
  static const String homeTitle= 'Trang chủ';
  static const String homeTitleDialog= 'Cảnh báo!';

  //login
  static const String userName = 'Tên đăng nhập';
  static const String passWord = 'Mật khẩu';
  static const String errUserName = 'Tên đăng nhập không đúng định dạng';
  static const String errPassWord = 'Tên đăng nhập không được bỏ trống';


  static const String localTitle= 'Cục bộ!';
  static const String emptyLocal= 'Bạn chưa có bài viết nào!';

  //dialog
  static const String ok= 'Đồng ý';
  static const String cancel= 'Trở lại';

  //handle error dio
  static const String errorConnectTimeout= 'Hết thời gian xác thực! Vui lòng kiểm tra kết nối mạng và thử lại!!!';
  static const String errorCancel= 'Yêu cầu đến máy chủ đã bị hủy. Liên hệ với đội ngũ kĩ thuật!!!';
  static const String errorStatusCode= 'Máy chủ bảo trì!!!';
  static const String errorNotConnect= 'Không có kết nối mạng , kiểm tra kết nối và thử lại sau!!!';
}