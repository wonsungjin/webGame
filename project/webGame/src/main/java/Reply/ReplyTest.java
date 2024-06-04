package Reply;

public class ReplyTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReplyDAO dao = new ReplyDAO();
//		ReplyVO vo =new ReplyVO();
//		vo.setReply("머임");
//		vo.setUser_seq(1);
//		dao.replyInsert(se);
		 ReplyVO vo = dao.replySelectOne(1);
		System.out.println(vo.getReply()+" "+vo.getCreated_date()+" "+vo.getReply_seq()+" "+vo.getUpdated_date()+" "+vo.getUser_seq());
	}

}
