using System;

using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Util;
using System.Collections.Generic;

namespace Snowlight.Game.Pets
{
    public class Pet
    {
        public static readonly List<int> PET_EXP_LEVELS = new List<int>() { 100, 200, 400, 600, 900, 1300, 1800, 2400, 3100,
            3900, 4800, 5800, 6900, 8100, 9400, 10800, 12300, 14000, 15800, 17700 };
        public static readonly List<int> PET_ENERGY_LEVELS = new List<int>() { 120, 140, 160, 180, 200, 220, 240, 260, 280,
            300, 320, 340, 360, 380, 400, 420, 440, 460, 480, 500 };

        private uint mId;
        private string mName;
        private int mType;
        private int mRace;
        private uint mOwnerId;
        private uint mRoomId;
        private Vector3 mRoomPosition;
        private double mTimestamp;
        private int mExperience;
        private int mEnergy;
        private int mHappiness;
        private int mScore;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Name
        {
            get
            {
                return mName;
            }
        }

        public string Look
        {
            get
            {
                return mType + " " + mRace + " " + "ffffff";
            }
        }

        public int Type
        {
            get
            {
                return mType;
            }
        }

        public int Race
        {
            get
            {
                return mRace;
            }
        }

        public uint OwnerId
        {
            get
            {
                return mOwnerId;
            }
        }

        public string OwnerName
        {
            get
            {
                return CharacterResolverCache.GetNameFromUid(mOwnerId);
            }
        }

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public Vector3 RoomPosition
        {
            get
            {
                return mRoomPosition;
            }
        }

        public double Timestamp
        {
            get
            {
                return mTimestamp;
            }
        }

        public double AgeSeconds
        {
            get
            {
                return UnixTimestamp.GetCurrent() - mTimestamp;
            }
        }

        public int AgeDays
        {
            get
            {
                return (int)(AgeSeconds / 86400);
            }
        }

        public string ColorCode
        {
            get
            {
                return "ffffff";
            }
        }

        public int TotalLevels
        {
            get
            {
                return PET_EXP_LEVELS.Count;
            }
        }

        public int Level
        {
            get
            {
                int Level = 1;

                foreach (int Exp in PET_EXP_LEVELS)
                {
                    if (Exp > mExperience)
                    {
                        break;
                    }

                    Level++;
                }

                return Level > TotalLevels ? TotalLevels : Level;
            }
        }

        public int ExperienceTarget
        {
            get
            {
                return PET_EXP_LEVELS[Level - 1];
            }
        }

        public int Experience
        {
            get
            {
                return mExperience;
            }
        }

        public int Energy
        {
            get
            {
                return mEnergy;
            }

            set
            {
                mEnergy = value;

                if (mEnergy < 0)
                {
                    mEnergy = 0;
                }

                if (mEnergy > EnergyLimit)
                {
                    mEnergy = EnergyLimit;
                }
            }
        }

        public int Happiness
        {
            get
            {
                return mHappiness;
            }

            set
            {
                mHappiness = value;

                if (mHappiness < 0)
                {
                    mHappiness = 0;
                }

                if (mHappiness > HappinessLimit)
                {
                    mHappiness = HappinessLimit;
                }
            }
        }

        public int HappinessLimit
        {
            get
            {
                return 100;
            }
        }

        public int EnergyLimit
        {
            get
            {
                return PET_ENERGY_LEVELS[Level - 1];
            }
        }

        public int Score
        {
            get
            {
                return mScore;
            }

            set
            {
                mScore = value;
            }
        }
        
        public Pet(uint Id, string Name, int PetType, int Race, uint UserId, uint RoomId, Vector3 RoomPosition,
            double Timestamp, int Experience, int Energy, int Happiness, int Score)
        {
            mId = Id;
            mName = Name;
            mType = PetType;
            mRace = Race;
            mOwnerId = UserId;
            mRoomId = RoomId;
            mRoomPosition = RoomPosition;
            mTimestamp = Timestamp;
            mExperience = Experience;
            mEnergy = Energy;
            mHappiness = Happiness;
            mScore = Score;
        }

        public void MoveToUserInventory(uint UserId)
        {
            mRoomId = 0;
            mRoomPosition = new Vector3(0, 0, 0);
        }

        public void MoveToRoom(uint RoomId, Vector3 RoomPosition)
        {
            mRoomId = RoomId;
            mRoomPosition = RoomPosition;
        }

        public void SynchronizeDatabase(SqlDatabaseClient MySqlClient)
        {
            MySqlClient.SetParameter("id", mId);
            MySqlClient.SetParameter("roomid", mRoomId);
            MySqlClient.SetParameter("roompos", mRoomPosition.ToString());
            MySqlClient.SetParameter("exp", mExperience);
            MySqlClient.SetParameter("energy", mEnergy);
            MySqlClient.SetParameter("happy", mHappiness);
            MySqlClient.SetParameter("score", mScore);
            MySqlClient.ExecuteNonQuery("UPDATE pets SET room_id = @roomid, room_pos = @roompos, experience = @exp, energy = @energy, happiness = @happy, score = @score WHERE id = @id LIMIT 1");
        }
    }
}
