package Servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 String uploadDir = "C:\\Users\\wonseongjin.DESKTOP-VPVHF7V\\Desktop\\webGame\\project\\webGame\\src\\main\\webapp\\webGL"; // 파일을 저장할 디렉토리 경로

         DiskFileItemFactory factory = new DiskFileItemFactory();
         factory.setRepository(new File(uploadDir));
         ServletFileUpload upload = new ServletFileUpload(factory);

         try {
             List<FileItem> items = upload.parseRequest(request);
             for (FileItem item : items) {
                 if (!item.isFormField()) {
                     String fileName = item.getName(); // 원본 파일 이름 가져오기

                     // 파일 이름이 비어 있지 않은 경우에만 처리
                     if (fileName != null && !fileName.isEmpty()) {
                         // 파일 확장자 추출
                         String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                         // 새 파일 이름 생성
                         String newFileName = "custom_filename" + fileExtension;

                         File uploadedFile = new File(uploadDir + File.separator + newFileName);
                         item.write(uploadedFile);

                         response.getWriter().println("파일이 업로드되었습니다.");
                     }
                 }
             }
         } catch (Exception e) {
             response.getWriter().println("파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
         }
    }

}
