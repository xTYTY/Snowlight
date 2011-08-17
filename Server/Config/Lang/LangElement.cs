using System;
using System.Net;

namespace Snowlight.Config.Lang
{
    public enum LangElementType
    {
        Text = 0
    }

    public class LangElement
    {
        private string mKey;
        private LangElementType mType;
        private object mCurrentValue;
        private bool mUserConfigured;

        public string Key
        {
            get
            {
                return mKey;
            }
        }

        public LangElementType Type
        {
            get
            {
                return mType;
            }
        }

        public object CurrentValue
        {
            get
            {
                return mCurrentValue;
            }

            set
            {
                string RawValue = value.ToString();

                switch (mType)
                {
                    default:
                    case LangElementType.Text:

                        mCurrentValue = RawValue;
                        break;

                }

                mUserConfigured = true;
            }
        }

        public bool UserConfigured
        {
            get
            {
                return mUserConfigured;
            }
        }

        public LangElement(string Key, LangElementType Type, object DefaultValue)
        {
            mKey = Key;
            mType = Type;
            CurrentValue = DefaultValue;
            mUserConfigured = false;
        }
    }
}
