using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Items;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Rooms.Trading
{
    public static class TradeHandler
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_INITIATE, new ProcessRequestCallback(TradeInitiate));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_STOP, new ProcessRequestCallback(TradeStop));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_END, new ProcessRequestCallback(TradeStop));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_OFFER, new ProcessRequestCallback(TradeOffer));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_TAKE_BACK, new ProcessRequestCallback(TradeTakeBack));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_ACCEPT, new ProcessRequestCallback(TradeAccept));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_MODIFY, new ProcessRequestCallback(TradeModify));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_TRADE_COMPLETE, new ProcessRequestCallback(TradeComplete));
        }

        private static void TradeInitiate(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.Info.CanTrade)
            {
                return;
            }

            RoomActor TargetActor = Instance.GetActor(Message.PopWiredUInt32());
            RoomActor SelfActor = Instance.GetActorByReferenceId(Session.CharacterId);

            if (TargetActor == null || TargetActor.Type != RoomActorType.UserCharacter || SelfActor == null || 
                TargetActor.ReferenceId == SelfActor.ReferenceId)
            {
                return;
            }

            Session TargetSession = SessionManager.GetSessionByCharacterId(TargetActor.ReferenceId);

            if (TargetSession == null)
            {
                return;
            }

            if (!Instance.TradeManager.InitiateTrade(Session.CharacterId, TargetSession.CharacterId))
            {
                Session.SendData(RoomTradeCannotInitiate.Compose());
                return;
            }

            ServerMessage TradeInitiatedMessage = TradeInitiatedComposer.Compose(Session.CharacterId, Session.HasRight("trade"),
                TargetSession.CharacterId, TargetSession.HasRight("trade"));

            Session.SendData(TradeInitiatedMessage);
            TargetSession.SendData(TradeInitiatedMessage);

            SelfActor.SetStatus("trd");
            SelfActor.UpdateNeeded = true;

            TargetActor.SetStatus("trd");
            TargetActor.UpdateNeeded = true;
        }

        private static void TradeStop(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);

            if (Trade == null)
            {
                return;
            }

            Instance.TradeManager.StopTradeForUser(Session.CharacterId);
            Session.SendData(TradeAbortedComposer.Compose(Session.CharacterId));

            RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

            if (Actor != null)
            {
                Actor.RemoveStatus("trd");
                Actor.UpdateNeeded = true;
            }

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ? 
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession != null)
            {
                Instance.TradeManager.StopTradeForUser(TargetSession.CharacterId);
                TargetSession.SendData(TradeAbortedComposer.Compose(Session.CharacterId));

                RoomActor TargetActor = Instance.GetActorByReferenceId(TargetSession.CharacterId);

                if (TargetActor != null)
                {
                    TargetActor.RemoveStatus("trd");
                    TargetActor.UpdateNeeded = true;
                }
            }
        }

        private static void TradeOffer(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);
            Item Item = Session.InventoryCache.GetItem(Message.PopWiredUInt32());

            if (Trade == null || Item == null || !Item.CanTrade ||
                !Trade.OfferItem(Session.CharacterId == Trade.UserOne, Item))
            {
                return;
            }

            ServerMessage TradeOffers = TradeOffersComposer.Compose(Trade);
            Session.SendData(TradeOffers);

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ?
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession != null)
            {
                TargetSession.SendData(TradeOffers);
            }
        }

        private static void TradeTakeBack(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);
            Item Item = Session.InventoryCache.GetItem(Message.PopWiredUInt32());

            if (Trade == null || Item == null || !Item.CanTrade ||
                !Trade.TakeBackItem(Session.CharacterId == Trade.UserOne, Item.Id))
            {
                return;
            }

            ServerMessage TradeOffers = TradeOffersComposer.Compose(Trade);
            Session.SendData(TradeOffers);

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ?
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession != null)
            {
                TargetSession.SendData(TradeOffers);
            }
        }

        private static void TradeAccept(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);

            if (Trade == null || !Trade.AcceptTrade(Trade.UserOne == Session.CharacterId))
            {
                return;
            }

            ServerMessage TradeAcceptState = TradeAcceptStateComposer.Compose(Session.CharacterId, true);
            ServerMessage TradeFinalizing = (Trade.TradeStage == TradeStage.Finalizing ? TradeFinalizingComposer.Compose()
                : null);

            Session.SendData(TradeAcceptState);

            if (TradeFinalizing != null)
            {
                Session.SendData(TradeFinalizing);
            }

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ?
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession != null)
            {
                TargetSession.SendData(TradeAcceptState);

                if (TradeFinalizing != null)
                {
                    TargetSession.SendData(TradeFinalizing);
                }
            }
        }

        private static void TradeComplete(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);

            if (Trade == null)
            {
                return;
            }

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ?
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession == null || !Trade.AcceptTrade(Trade.UserOne == Session.CharacterId))
            {
                return;
            } 

            if (Trade.TradeStage == TradeStage.Finalized)
            {
                Session User1 = (TargetSession.CharacterId == Trade.UserOne ? TargetSession : Session);
                Session User2 = (TargetSession.CharacterId == Trade.UserTwo ? TargetSession : Session);

                Trade.DeliverItems(User1, User2);

                Session.SendData(TradeFinalizedComposer.Compose());
                TargetSession.SendData(TradeFinalizedComposer.Compose());

                Instance.TradeManager.StopTradeForUser(Session.CharacterId);
                Instance.TradeManager.StopTradeForUser(TargetSession.CharacterId);

                RoomActor Actor1 = Instance.GetActorByReferenceId(Session.CharacterId);
                RoomActor Actor2 = Instance.GetActorByReferenceId(TargetSession.CharacterId);

                if (Actor1 != null)
                {
                    Actor1.RemoveStatus("trd");
                    Actor1.UpdateNeeded = true;
                }

                if (Actor2 != null)
                {
                    Actor2.RemoveStatus("trd");
                    Actor2.UpdateNeeded = true;
                }
            }
        }

        private static void TradeModify(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Trade Trade = Instance.TradeManager.GetTradeForUser(Session.CharacterId);

            if (Trade == null || !Trade.ModifyTrade(Trade.UserOne == Session.CharacterId))
            {
                return;
            }

            ServerMessage TradeAcceptState = TradeAcceptStateComposer.Compose(Session.CharacterId, false);
            Session.SendData(TradeAcceptState);

            Session TargetSession = SessionManager.GetSessionByCharacterId(Trade.UserOne == Session.CharacterId ?
                Trade.UserTwo : Trade.UserOne);

            if (TargetSession != null)
            {
                TargetSession.SendData(TradeAcceptState);
            }
        }
    }
}
