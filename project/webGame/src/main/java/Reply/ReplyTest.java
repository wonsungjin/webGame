package Reply;

import java.util.ArrayList;

public class ReplyTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReplyDAO dao = new ReplyDAO();
//		vo.setReply("머임");
//		vo.setUser_seq(1);
//		dao.replyInsert(se);
		ArrayList< ReplyVO> list = dao.replySelect("timeChase");
		for(ReplyVO vo : list)
		{
		System.out.println(vo.getReply()+" "+vo.getCreated_date()+" "+vo.getReply_seq()+" "+vo.getUpdated_date()+" "+vo.getUser_seq());
		}
//		UserDAO dao = new UserDAO();
//		UserVO vo =  dao.userSelectOne(1);
//		System.out.println(vo.getUserid());
	}

}
