package Servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import GameTable.GameTableDAO;
import GameTable.GameTableVO;
import User.UserVO;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pagecode = request.getParameter("pagecode");

		if (pagecode.equals("contactMove")) {
			HttpSession session = request.getSession();
			UserVO user = (UserVO) session.getAttribute("user");
			if (user != null) {
				response.sendRedirect("contact.jsp");
			} else {
				response.sendRedirect("login.jsp");
			}

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String pagecode = request.getParameter("pagecode");
		if (pagecode.equals("file")) {
		    String userHome = System.getProperty("user.home");
		    String uploadDir = Paths.get(userHome, "Desktop", "webGame", "project", "webGame", "src", "main", "webapp", "webGL").toString();
		    String uploadImgDir = Paths.get(userHome, "Desktop", "webGame", "project", "webGame", "src", "main", "webapp", "img", "gameLogo").toString();
		    DiskFileItemFactory factory = new DiskFileItemFactory();
		    factory.setRepository(new File(uploadDir));
		    ServletFileUpload upload = new ServletFileUpload(factory);

		    try {
		        List<FileItem> items = upload.parseRequest(request);
		        String gameName = null;
		        String gameContent = null;
		        String webGL = null;
		        int user_seq = 0;

		        for (FileItem item : items) {
		            if (item.isFormField()) {
		                if (item.getFieldName().equals("gameName")) {
		                    gameName = item.getString("UTF-8");
		                } else if (item.getFieldName().equals("gameContent")) {
		                    gameContent = item.getString("UTF-8");
		                } else if (item.getFieldName().equals("user_seq")) {
		                    user_seq = Integer.parseInt(item.getString("UTF-8"));
		                } else if (item.getFieldName().equals("webGL")) {
		                    webGL = item.getString("UTF-8");
		                }
		            }
		        }

		        for (FileItem item : items) {
		            if (!item.isFormField()) {
		                String fileName = item.getName(); // 원본 파일 이름 가져오기

		                if (fileName != null && !fileName.isEmpty()) {
		                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
		                    String fileNameWithoutExtension = fileName.substring(0, fileName.lastIndexOf("."));
		                    String newFileName = fileNameWithoutExtension;

		                    File uploadedFile = new File(uploadDir + File.separator + newFileName + fileExtension);

		                    if (fileExtension.equalsIgnoreCase(".jpg") || fileExtension.equalsIgnoreCase(".jpeg") || fileExtension.equalsIgnoreCase(".png")) {
		                        uploadedFile = new File(uploadImgDir + File.separator + newFileName + ".png");
		                    }

		                    if (uploadedFile.exists()) {
		                        response.getWriter().println("파일 업로드 실패: 이미 존재하는 파일입니다.");
		                        uploadedFile.delete();
		                    }

		                    item.write(uploadedFile);

		                    if (fileExtension.equalsIgnoreCase(".zip")) {
		                        File unzipDir = new File(uploadDir + File.separator + newFileName);
		                        if (!unzipDir.exists()) {
		                            unzipDir.mkdirs();
		                        }

		                        ZipFile zipFile = new ZipFile(uploadedFile);
		                        Enumeration<? extends ZipEntry> entries = zipFile.entries();
		                        while (entries.hasMoreElements()) {
		                            ZipEntry entry = entries.nextElement();
		                            File entryDestination = new File(unzipDir, entry.getName());
		                            if (entry.isDirectory()) {
		                                entryDestination.mkdirs();
		                            } else {
		                                InputStream entryInputStream = zipFile.getInputStream(entry);
		                                OutputStream entryOutputStream = new FileOutputStream(entryDestination);
		                                byte[] buffer = new byte[1024];
		                                int bytesRead;
		                                while ((bytesRead = entryInputStream.read(buffer)) != -1) {
		                                    entryOutputStream.write(buffer, 0, bytesRead);
		                                }
		                                entryInputStream.close();
		                                entryOutputStream.close();
		                            }
		                        }
		                        zipFile.close();
		                        uploadedFile.delete();
		                    }
		                }
		            }
		        }
		        response.getWriter().println("파일이 업로드되었습니다.");
		        GameTableDAO gdao = new GameTableDAO();
		        GameTableVO gvo = new GameTableVO();
		        gvo.setContents(gameContent);
		        gvo.setGameName(gameName);
		        gvo.setWebGL(webGL);
		        gvo.setUser_seq(user_seq);
		        gdao.gameTableInsert(gvo);
		        response.sendRedirect("index.jsp");
		    } catch (Exception e) {
		        response.getWriter().println("파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
		    }
		}

	}
}
