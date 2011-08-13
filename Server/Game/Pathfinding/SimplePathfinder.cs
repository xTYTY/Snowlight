using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Rooms;
using Snowlight.Specialized;

namespace Snowlight.Game.Pathfinding
{
    public class SimplePathfinder : Pathfinder
    {
        private RoomInstance mCurrentInstance;
        private uint mActorId;
        private List<Vector2> mPath;
        private Vector2 mTarget;

        public override Vector2 Target
        {
            get
            {
                return mTarget;
            }
        }

        public override bool IsCompleted
        {
            get
            {
                return (mPath.Count == 0);
            }
        }

        public override void SetRoomInstance(RoomInstance Room, uint ActorId)
        {
            mCurrentInstance = Room;
            mActorId = ActorId;
            mPath = new List<Vector2>();
            mTarget = null;
        }

        public override void MoveTo(Vector2 Position)
        {
            lock (mPath)
            {
                mPath.Clear();
                mTarget = Position;
                mPath = FindPath();
            }
        }

        public override void Clear()
        {
            lock (mPath)
            {
                mPath.Clear();
                mTarget = null;
            }
        }

        public override Vector2 GetNextStep()
        {
            lock (mPath)
            {
                if (IsCompleted)
                {
                    return null;
                }

                Vector2 NextStep = mPath[0];
                mPath.Remove(NextStep);
                return NextStep;
            }
        }

        private List<Vector2> FindPath()
        {
            if (mCurrentInstance == null || mTarget == null)
            {
                return null;
            }

            RoomActor Actor = mCurrentInstance.GetActor(mActorId);

            if (Actor == null)
            {
                return null;
            }

            List<Vector2> Points = new List<Vector2>();
            bool MadeProgress = true;

            while (MadeProgress)
            {
                Vector2 NextPoint = new Vector2(-1, -1);
                Vector2 LastPoint = null;

                if (Points.Count > 0)
                {
                    LastPoint = Points[Points.Count - 1];
                }

                int FromX = 0;
                int FromY = 0;

                if (LastPoint != null)
                {
                    FromX = LastPoint.X;
                    FromY = LastPoint.Y;
                }
                else
                {
                    FromX = Actor.Position.X;
                    FromY = Actor.Position.Y;
                }

                if (FromX == mTarget.X && FromY == mTarget.Y)
                {
                    break;
                }

                if (FromX > mTarget.X && FromY > mTarget.Y)
                {
                    NextPoint = new Vector2(FromX - 1, FromY - 1);
                }
                else if (FromX < mTarget.X && FromY < mTarget.Y)
                {
                    NextPoint = new Vector2(FromX + 1, FromY + 1);
                }
                else if (FromX > mTarget.X && FromY < mTarget.Y)
                {
                    NextPoint = new Vector2(FromX - 1, FromY + 1);
                }
                else if (FromX < mTarget.X && FromY > mTarget.Y)
                {
                    NextPoint = new Vector2(FromX + 1, FromY - 1);
                }
                else if (FromX > mTarget.X)
                {
                    NextPoint = new Vector2(FromX - 1, FromY);
                }
                else if (FromX < mTarget.X)
                {
                    NextPoint = new Vector2(FromX + 1, FromY);
                }
                else if (FromY < mTarget.Y)
                {
                    NextPoint = new Vector2(FromX, FromY + 1);
                }
                else if (FromY > mTarget.Y)
                {
                    NextPoint = new Vector2(FromX, FromY - 1);
                }

                MadeProgress = (NextPoint.X > -1 && NextPoint.Y > -1);

                if (LastPoint != null && NextPoint.X == LastPoint.X && NextPoint.Y == LastPoint.Y)
                {
                    MadeProgress = false;
                }

                if (MadeProgress)
                {
                    Points.Add(NextPoint);
                }
            }

            return Points;         
        }
    }
}
