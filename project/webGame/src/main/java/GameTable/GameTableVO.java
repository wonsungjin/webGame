package GameTable;

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
public class GameTableVO {
	private String webGL;
	private String gameName;
	private String contents;
	private int grade;
	private String created_date;
	private String updated_date;
	private int user_seq;
}
