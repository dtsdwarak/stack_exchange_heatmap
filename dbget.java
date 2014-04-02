import java.sql.* ;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.JSONArray;

public class dbget extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {

        response.setContentType("text/json");

        String technology_name = request.getParameter("technology_select");
        String className = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/stack_exchange";
        String user = "root";
        String password = "dtsdwarak";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        Statement s;
        int value=0,lat,lng,number_of_dev,rating;
        JSONArray list = new JSONArray();
        try {
            Class.forName(className);
            con = DriverManager.getConnection(url, user, password);
            String sql = "select latitude,longitude,no,rating from " + technology_name;
            System.out.println("OUTPUT ========= " + sql);
            // String sql = "insert into users(name,tag,about) values('" + a + "','" + b + "','" + c + "');";
            ps = con.prepareStatement(sql);
            rs=ps.executeQuery();

            //JSON Array for output
            

            while (rs.next()) {
                lat = rs.getInt(1);
                lng = rs.getInt(2); 
                number_of_dev = rs.getInt(3);
                rating = rs.getInt(4);

                JSONObject obj = new JSONObject();
                obj.put("lat",lat);
                obj.put("lng",lng);
                obj.put("count",new Integer(rating/number_of_dev)*0.01);

                //Adding the object to arraylist
                list.add(obj);

                System.out.print("new json object = " + obj);
            }
//           System.out.println(value);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        String jsonResult = JSONArray.toJSONString(list);
        request.getRequestDispatcher("index.jsp?value=" + jsonResult).forward(request, response);
        // request.getRequestDispatcher("http://google.com");
    }
}
