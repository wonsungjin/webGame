	package User;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString

public class UserVO 
{
	private int user_seq;
	private String userid;
	private String username;
	private String password;
	private String useremail;
	private String created_date;
	private String updated_date;
	//추가부분
}
