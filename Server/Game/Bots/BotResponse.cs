using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Snowlight.Util;


namespace Snowlight.Game.Bots
{
    public class BotResponse
    {
        private List<string> mTriggers;
        private List<string> mResponse;
        private int mResponseServeId;

        public int ResponseServeId
        {
            get
            {
                return mResponseServeId;
            }
        }

        public BotResponse(List<string> Triggers, List<string> Responses, int ResponseServeId)
        {
            mTriggers = Triggers;
            mResponse = Responses;
            mResponseServeId = ResponseServeId;
        }

        public bool MatchesTrigger(string UserQuery)
        {
            UserQuery = UserQuery.ToLower();

            foreach (string Trigger in mTriggers)
            {
                if (UserQuery.Contains(Trigger.ToLower()))
                {
                    return true;
                }
            }

            return false;
        }

        public string GetResponse()
        {
            if (mResponse.Count < 1)
            {
                return null;
            }

            return mResponse[RandomGenerator.GetNext(0, (mResponse.Count - 1))];
        }
    }
}
