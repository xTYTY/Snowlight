using System;
using System.Net;

namespace Snowlight.Config
{
    public enum ConfigElementType
    {
        Text = 0,
        Boolean = 1,
        Integer = 2,
        IpAddress = 3
    }

    public class ConfigElement
    {
        private string mKey;
        private ConfigElementType mType;
        private object mCurrentValue;
        private bool mUserConfigured;

        public string Key
        {
            get
            {
                return mKey;
            }
        }

        public ConfigElementType Type
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
                    case ConfigElementType.Boolean:

                        mCurrentValue = false;

                        if (RawValue == "1" || RawValue.ToLower() == "true")
                        {
                            mCurrentValue = true;
                        }

                        break;

                    case ConfigElementType.Integer:

                        int IntegerValue = 0;
                        int.TryParse(RawValue, out IntegerValue);
                        mCurrentValue = IntegerValue;
                        break;

                    case ConfigElementType.IpAddress:

                        IPAddress IPValue = IPAddress.Any;
                        IPAddress.TryParse(RawValue, out IPValue);
                        mCurrentValue = IPValue;
                        break;

                    default:
                    case ConfigElementType.Text:

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

        public ConfigElement(string Key, ConfigElementType Type, object DefaultValue)
        {
            mKey = Key;
            mType = Type;
            CurrentValue = DefaultValue;
            mUserConfigured = false;
        }
    }
}
