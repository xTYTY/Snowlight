using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Game.Items
{
    public class CatalogItem
    {
        private uint mId;
        private uint mDefinitionId;
        private string mDisplayName;
        private int mCostCredits;
        private int mCostPixels;
        private int mAmount;
        private string mPresetFlags;
        private int mClubRestriction;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public uint DefinitionId
        {
            get
            {
                return mDefinitionId;
            }
        }

        public ItemDefinition Definition
        {
            get
            {
                return ItemDefinitionManager.GetDefinition(mDefinitionId);
            }
        }

        public string DisplayName
        {
            get
            {
                return mDisplayName;
            }
        }

        public int CostCredits
        {
            get
            {
                return mCostCredits;
            }
        }

        public int CostActivityPoints
        {
            get
            {
                return mCostPixels;
            }
        }

        public int Amount
        {
            get
            {
                return (mAmount > 1 ? mAmount : 1);
            }
        }

        public bool ShowPresetFlags
        {
            get
            {
                return (Definition.Behavior != ItemBehavior.Moodlight);
            }
        }

        public string PresetFlags
        {
            get
            {
                return mPresetFlags;
            }
        }

        public int ClubRestriction
        {
            get
            {
                return mClubRestriction;
            }
        }

        public CatalogItem(uint Id, uint BaseId, string Name, int CostCredits, int CostPixels, int Amount, string PresetFlags,
            int ClubRestriction)
        {
            mId = Id;
            mDefinitionId = BaseId;
            mDisplayName = Name;
            mCostCredits = CostCredits;
            mCostPixels = CostPixels;
            mAmount = Amount;
            mPresetFlags = PresetFlags;
            mClubRestriction = ClubRestriction;
        }
    }
}
