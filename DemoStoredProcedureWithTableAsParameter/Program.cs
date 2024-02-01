using System.Data;
using System.Data.SqlClient;

namespace DemoStoredProcedureWithTableAsParameter
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=SampleDatabase;Integrated Security=True;Connect Timeout=60;Encrypt=False;";
                connection.Open();

                DataTable produits = new DataTable();
                produits.Columns.AddRange([
                    new DataColumn("ProduitId", typeof(int)),
                    new DataColumn("Quantite", typeof(int)),
                ]);
                produits.Rows.Add(1, 5);
                produits.Rows.Add(42, 1);

                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "CSP_AddCommand";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("Produits", produits);

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
