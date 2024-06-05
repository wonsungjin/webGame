package Reply;
import User.UserVO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReplyVO {
	int reply_seq;
	int user_seq;
	String reply;
	String created_date;
	String updated_date;
	String webGL;
	int grade;
	UserVO userVO;
}
