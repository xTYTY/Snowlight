using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Text;

using Snowlight.Storage;
using Snowlight.Specialized;
using Snowlight.Game.Pets;

namespace Snowlight.Game.Items
{
    public class PetInventoryCache
    {
        private uint mCharacterId;
        private Dictionary<uint, Pet> mInner;
        private object mSyncRoot;

        public Dictionary<uint, Pet> Pets
        {
            get
            {
                lock (mSyncRoot)
                {
                    Dictionary<uint, Pet> Copy = new Dictionary<uint, Pet>();

                    foreach (KeyValuePair<uint, Pet> Item in mInner)
                    {
                        Copy.Add(Item.Key, Item.Value);
                    }

                    return new Dictionary<uint, Pet>(Copy);
                }
            }
        }

        public PetInventoryCache(SqlDatabaseClient MySqlClient, uint CharacterId)
        {
            mCharacterId = CharacterId;
            mInner = new Dictionary<uint, Pet>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("userid", mCharacterId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM pets WHERE user_id = @userid AND room_id = 0");

                foreach (DataRow Row in Table.Rows)
                {
                    Pet Pet = PetFactory.GetPetFromDatabaseRow(Row);
                    mInner.Add(Pet.Id, Pet);
                }
            }
        }

        public void Add(Pet Pet)
        {
            lock (mInner)
            {
                if (!mInner.ContainsKey(Pet.Id))
                {
                    mInner.Add(Pet.Id, Pet);
                }
            }
        }

        public bool Remove(uint Id)
        {
            lock (mInner)
            {
                if (mInner.ContainsKey(Id))
                {
                    return mInner.Remove(Id);
                }
            }

            return false;
        }

        public Pet GetPet(uint Id)
        {
            lock (mInner)
            {
                if (mInner.ContainsKey(Id))
                {
                    return mInner[Id];
                }
            }

            return null;
        }
    }
}
