using System;
using System.Text;

namespace Snowlight.Config
{
    public static class Constants
    {
        public static readonly string           ConsoleTitle                = "Snowlight";
        public static readonly int              ConsoleWindowWidth          = 90;
        public static readonly int              ConsoleWindowHeight         = 30;
        public static readonly string           DataFileDirectory           = Environment.CurrentDirectory + "\\data";
        public static readonly string           LogFileDirectory            = Environment.CurrentDirectory + "\\logs";
        public static readonly string           LangFileDirectory           = Environment.CurrentDirectory + "\\lang";
        public static readonly Encoding         DefaultEncoding             = Encoding.Default;
        public static readonly char             LineBreakChar               = Convert.ToChar(13);
    }
}
