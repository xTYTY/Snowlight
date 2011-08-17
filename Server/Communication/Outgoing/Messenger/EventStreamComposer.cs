using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class EventStreamComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
            ServerMessage Message = new ServerMessage(OpcodesOut.GET_STREAM_EVENT);
            //SBsMlUtBH31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifYIDQAHI36954090.:DarkSaske:.s{`UtBH31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifYIDQAHI45789055..S3phiroth..ifqR}H31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifZvOQAHI45485689.Scissionistaj^Y`{H31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifY|OQAHI31837771.:ketti94:.klJ`{H31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifY|OQAHI45746957Sparvierej^}_{H31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifY|OQAHI41683680-.:TheRed:.-hI|O{H31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifX}OQAHI33319042.:Habbina94:.tLxTqBJ31266408pquadro20mhttp://www.habbo.com/habbo-imaging/badge/ACH_SummerQuestCompleted100ef9b85a9ef6131096c94669a04cdea1.png[r[KHIACH_SummerQuestCompleted10twLkBH31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifZr[QAHI36814141GoofyllllltvLkBH31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifZr[QAHI29206050ricky94ctwMGMkBH31266408pquadro20mhttp://www.habbo.com/habbo-imaging/avatar/hd-195-27.ch-215-62.lg-275-62.sh-295-62.ha-1004-62,s-2.g-0.d-2.h-2.a-0,04e3deb736d1e0067d943163b8a333c2.gifZr[QAHI31329620,HiPNOTiiiC
            return Message;
        }
    }
}
