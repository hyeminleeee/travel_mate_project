package xyz.itwill.auth;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.TravelUserDAO;
import xyz.itwill.dto.TravelUser;

//테이블에 저장된 사용자 정보 및 권한 정보를 검색하여 인증 처리 후 사용자 정보 및 권한 정보가 저장된
//UserDetails 객체를 반환하는 메소드가 작성된 클래스
//=> UserDetailsService 인터페이스를 상속받아 작성
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
	private final TravelUserDAO travelUserDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		TravelUser user=travelUserDAO.selectTravelUserByUserid(username);
		
		if(user == null) {
			throw new UsernameNotFoundException(username);
		}
		
		return new CustomUserDetails(user);
		
	}

}
