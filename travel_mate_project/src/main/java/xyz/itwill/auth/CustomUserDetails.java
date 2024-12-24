package xyz.itwill.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import xyz.itwill.dto.TravelAuth;
import xyz.itwill.dto.TravelUser;

//인증된 사용자 정보와 권한 정보를 저장하기 위한 클래스
//=> Spring Security로 인증 성공 후 사용자 정보 및 권한 정보가 저장된 UserDetails 객체를 
//Spring Security로부터 반환받아 사용 가능하지만 사용자 정보 및 권한 정보를 원하는 형태로 
//제공받기 위한 클래스 작성
//(이 반환된 UserDetails 객체는 기본적으로 Spring Security가 만들어준 거다. 그래서 아이디, 비밀번호,
//enabled 정보 정도만 저장할 수 있다.)
//그런데 여기에서 이걸 커스터마이징 해서 인증된 사용자의 전체적인 정보를 모두 저장해보자는 의도이다. 
//그러기 위해 아래와 같이 코드를 작성하는 것이다.
//=> UserDetails 인터페이스를 상속받아 작성 - User 클래스를 상속받아 작성 가능

//인증성공한 다음에 Spring Security로부터 CustomUserDetails 객체를 제공받아 요청처리메소드나 JSP에서
//사용할수도 있다.
@Data
public class CustomUserDetails implements UserDetails {
	private static final long serialVersionUID = 1L;
	
	//인증된 사용자 정보가 저장될 필드 작성
	private String userId;
	private String userPw;
	private String userMemberName;
	private String userNickname;
	private String userEmail;
	private String userPhone;
	private String userIntroduction;
	private String userAge;
	private String userGender;
	private String userRegdate;
	private int userStatus;
	private String userEnabled;
	
	//인증된 사용자의 권한 정보가 저장될 필드 작성
	private List<GrantedAuthority> travelAuthList;
	
	//매개변수로 전달받은 SecurityUser 객체의 필드값을 CustomUserDetails 객체의 필드에 저장
	public CustomUserDetails(TravelUser user) {
		this.userId=user.getUserId();
		this.userPw=user.getUserPw();
		this.userMemberName=user.getUserName();
		this.userNickname=user.getUserNickname();
		this.userEmail=user.getUserEmail();
		this.userPhone=user.getUserPhone();
		this.userIntroduction=user.getUserIntroduction();
		this.userAge=user.getUserAge();
		this.userGender=user.getUserGender();
		this.userRegdate=user.getUserRegdate();
		this.userStatus=user.getUserStatus();
		this.userEnabled=user.getUserEnabled();
		
		this.travelAuthList=new ArrayList<GrantedAuthority>();
		//검색된 사용자의 권한 정보를 GrantedAuthority 객체로 생성하여 List 객체의 요소값으로 저장
		for(TravelAuth auth : user.getTravelAuthList()) {
			travelAuthList.add(new SimpleGrantedAuthority(auth.getUserAuth()));
		}
		
	}
	
	//인증된 사용자의 권한정보를 반환하는 메소드
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return travelAuthList;
	}
	
	//인증된 사용자의 비밀번호를 반환하는 메소드
	@Override
	public String getPassword() {
		return userPw;
	}
	
	//인증된 사용자의 식별자(아이디)를 반환하는 메소드
	@Override
	public String getUsername() {
		return userId;
	}

	//인증된 사용자의 유효기간 상태를 반환하는 메소드
	//=> false : 사용자 유효기간 초과 상태, true : 사용자 유효기간 미초과 상태
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	//인증된 사용자의 잠금 상태를 반환하는 메소드
	//=> false : 잠금 상태, true : 해제 상태
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	//인증된 사용자 비밀번호의 유효기간 상태를 반환하는 메소드
	//=> false : 사용자 비밀번호 유효기간 초과 상태, true : 사용자 비밀번호 유효기간 미초과 상태
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	//인증된 사용자의 활성화 상태를 반환하는 메소드
	//=> false : 사용자 비활성화 상태, true : 사용자 활성화 상태
	@Override
	public boolean isEnabled() {
		if(userEnabled.equals("0")) {
			return false;
		} else {
			return true;
		}
	}

}
