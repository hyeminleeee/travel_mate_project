package xyz.itwill.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
create table travel_auth(
user_id varchar2(100)
, user_auth varchar2(50)
    , constraint userauth_userid_fk foreign key(user_id) references travel_user(user_id));
    
create unique index userauth_userid_index on travel_auth(user_id, user_auth); 
*/

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TravelAuth {
	private String userId;
	private String userAuth;
}
