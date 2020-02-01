using System;
using System.Configuration;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace Bookings.Models
{
    public class ShowImage : IHttpHandler
    {
        public bool IsReusable
        {
            get
            {
                throw new NotImplementedException();
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            Int32 empno;
            if (context.Request.QueryString["id"] != null)
                empno = Convert.ToInt32(context.Request.QueryString["id"]);
            else
                throw new ArgumentException("No parameter specified");

            context.Response.ContentType = "image/jpeg";
            Stream strm = ShowEmpImage(empno);
            byte[] buffer = new byte[4096];
            int byteSeq = strm.Read(buffer, 0, 4096);

            while (byteSeq > 0)
            {
                context.Response.OutputStream.Write(buffer, 0, byteSeq);
                byteSeq = strm.Read(buffer, 0, 4096);
            }
            //context.Response.BinaryWrite(buffer);
        }

        public Stream ShowEmpImage(int empno)
        {
            string conn = ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;
            SqlConnection connection = new SqlConnection(conn);
            string sql = "SELECT* FROM  table WHERE empid = @ID";
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", empno);
            connection.Open();
            object img = cmd.ExecuteScalar();
            try
            {
                return new MemoryStream((byte[])img);
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
    }
}