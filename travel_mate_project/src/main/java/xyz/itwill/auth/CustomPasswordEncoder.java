package xyz.itwill.auth;

import org.springframework.security.crypto.password.PasswordEncoder;

//비밀번호를 전달받아 암호화 처리하여 반환하거나 암호화 처리된 비밀번호를 비교한 결과를 반환하는
//기능의 메소드가 작성된 클래스
//=> PasswordEncoder 인터페이스를 상속받아 작성
public class CustomPasswordEncoder implements PasswordEncoder {
	//매개변수로 전달받은 문자열을 암호화 처리해 반환하는 메소드
	@Override
	public String encode(CharSequence rawPassword) {
		return rawPassword.toString();
	}

	//매개변수로 전달받은 암호화된 문자열과 일반 문자열을 비교하여 비교결과를 논리값으로 반환하는
	//메소드
	//(원래는 암호화처리를 해야하는데, 우리는 일단 하지 않았다. 왜냐하면 우리가 만든 테이블에
	//비밀번호가 암호화 처리되어있지 않기 때문이다.)
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return rawPassword.toString().equals(encodedPassword);
	}

}
