using System;
using System.Data;

using MySql.Data.MySqlClient;

namespace Snowlight.Storage
{
    public class SqlDatabaseClient : IDisposable
    {
        private int mId;
        private double mLastActivity;
        private MySqlConnection mConnection;
        private MySqlCommand mCommand;
        private bool mAvailable;

        public int Id
        {
            get
            {
                return mId;
            }
        }

        public bool Available
        {
            get
            {
                return mAvailable;
            }

            set
            {
                mAvailable = value;
            }
        }

        public double TimeInactive
        {
            get
            {
                return UnixTimestamp.GetCurrent() - mLastActivity;
            }
        }

        public SqlDatabaseClient(int Id, MySqlConnection Connection)
        {
            mId = Id;
            mConnection = Connection;
            mCommand = new MySqlCommand();
            mCommand.Connection = mConnection;
            mAvailable = true;

            UpdateLastActivity();
        }

        /// <summary>
        /// Called when released from using() scope - does not actually dispose, just marks as available
        /// </summary>
        public void Dispose()
        {
            mAvailable = true;
            UpdateLastActivity();
            Output.WriteLine("(Sql) Released client " + Id + " for availability.", OutputLevel.DebugInformation);

            SqlDatabaseManager.PokeAllAwaiting();
        }

        /// <summary>
        /// Called when being removed 
        /// </summary>
        public void Close()
        {
            mConnection.Close();
            mCommand.Dispose();

            mConnection = null;
            mCommand = null;
        }

        private void UpdateLastActivity()
        {
            mLastActivity = UnixTimestamp.GetCurrent();
        }

        public void ClearParameters()
        {
            mCommand.Parameters.Clear();
        }

        public void SetParameter(string Key, object Value)
        {
            mCommand.Parameters.Add(new MySqlParameter(Key, Value));
        }

        public void ResetCommand()
        {
            mCommand.CommandText = null;

            ClearParameters();
        }

        public int ExecuteNonQuery(string CommandText)
        {
            mCommand.CommandText = CommandText;

            int Affected = mCommand.ExecuteNonQuery();

            ResetCommand();
            return Affected;
        }

        public DataSet ExecuteQuerySet(string CommandText)
        {
            DataSet DataSet = new DataSet();

            mCommand.CommandText = CommandText;

            using (MySqlDataAdapter Adapter = new MySqlDataAdapter(mCommand))
            {
                Adapter.Fill(DataSet);
            }

            ResetCommand();
            return DataSet;
        }

        public DataTable ExecuteQueryTable(string CommandText)
        {
            DataSet DataSet = ExecuteQuerySet(CommandText);
            return DataSet.Tables.Count > 0 ? DataSet.Tables[0] : null;
        }

        public DataRow ExecuteQueryRow(string CommandText)
        {
            DataTable DataTable = ExecuteQueryTable(CommandText);
            return DataTable.Rows.Count > 0 ? DataTable.Rows[0] : null;
        }

        public object ExecuteScalar(string CommandText)
        {
            mCommand.CommandText = CommandText;

            object ReturnValue = mCommand.ExecuteScalar();

            ResetCommand();
            return ReturnValue;
        }
    }
}
