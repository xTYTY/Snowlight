using System;
using System.Reflection;
using System.Collections.Generic;
using System.IO;
using Snowlight.Config;
using System.Text;

namespace Snowlight
{
    public enum OutputLevel
    {
        CriticalError = 3,
        Warning = 2,
        Notification = 1,
        Informational = 0,
        DebugInformation = -1
    }

    public static class Output
    {
        private static bool mEnableLogging;
        private static string mLogFilePath;
        private static OutputLevel mVerbosityLevel;
        private static object mWritebackSyncRoot;

        public static void InitializeStream(bool EnableLogging, OutputLevel VerbosityLevel)
        {
            mEnableLogging = EnableLogging;
            mVerbosityLevel = VerbosityLevel;
            mWritebackSyncRoot = new object();

            if (EnableLogging)
            {
                DateTime Now = DateTime.Now;
                string LogDirectory = Environment.CurrentDirectory + Constants.LogFileDirectory + "\\";
                mLogFilePath = LogDirectory + Now.Day + Now.Month + Now.Year + Now.Hour + Now.Minute + Now.Second + ".log";

                try
                {
                    if (!Directory.Exists(LogDirectory))
                    {
                        Directory.CreateDirectory(LogDirectory);
                    }

                    File.WriteAllText(mLogFilePath, ComposeDefaultLogHeader(), Constants.DefaultEncoding);
                }
                catch (Exception)
                {
                    mEnableLogging = false;
                }
            }

            ClearStream();
            WriteBanner();
        }

        public static void ClearStream()
        {
            Console.Clear();

            Console.Title = Constants.ConsoleTitle;
            Console.WindowWidth = Constants.ConsoleWindowWidth;
            Console.WindowHeight = Constants.ConsoleWindowHeight;

            ResetColorScheme();
        }

        private static void ResetColorScheme()
        {
            ApplyColorScheme(ConsoleColor.Gray, ConsoleColor.Black);
        }

        private static void ApplyColorScheme(ConsoleColor ForegroundColor)
        {
            ApplyColorScheme(ForegroundColor, ConsoleColor.Black);
        }

        private static void ApplyColorScheme(ConsoleColor ForegroundColor, ConsoleColor BackgroundColor)
        {
            Console.ForegroundColor = ForegroundColor;
            Console.BackgroundColor = BackgroundColor;
        }

        private static void SetColorSchemeForSeverity(OutputLevel SeverityLevel)
        {
            switch (SeverityLevel)
            {
                case OutputLevel.CriticalError:

                    ApplyColorScheme(ConsoleColor.Red);
                    break;

                case OutputLevel.Warning:

                    ApplyColorScheme(ConsoleColor.Yellow);
                    break;

                case OutputLevel.Notification:

                    ApplyColorScheme(ConsoleColor.Green);
                    break;

                case OutputLevel.DebugInformation:

                    ApplyColorScheme(ConsoleColor.DarkGray);
                    break;

                case OutputLevel.Informational:
                default:

                    ResetColorScheme();
                    break;
            }
        }

        public static void WriteBanner()
        {
            Console.BackgroundColor = ConsoleColor.DarkGray;
            Console.ForegroundColor = ConsoleColor.White;

            List<string> Lines = new List<string>();

            Lines.Add("   _________                    .__  .__       .__     __   ");
            Lines.Add("  /   _____/ ____   ______  _  _|  | |__| ____ |  |___/  |_   "          + "Snowlight server");
            Lines.Add("  \\_____  \\ /    \\ /  _ \\ \\/ \\/ /  | |  |/ ___\\|  |  \\   __\\  " + "Development version");
            Lines.Add("  /        \\   |  (  <_> )     /|  |_|  / /_/  >   Y  \\  |    "        + "Version G" + Assembly.GetExecutingAssembly().GetName().Version.ToString());
            Lines.Add(" /_______  /___|  /\\____/ \\/\\_/ |____/__\\___  /|___|  /__|    "      + "github.com/meth0d/snowlight");
            Lines.Add("         \\/     \\/                     /_____/      \\/      ");

            foreach (string Line in Lines)
            {
                int Spacing = Console.WindowWidth - Line.Length - 1;
                string Ln = Line;

                for (int s = 0; s < Spacing; s++)
                {
                    Ln += ' ';
                }

                Console.WriteLine(Ln);
            }

            Console.WriteLine();

            ApplyColorScheme(ConsoleColor.DarkGray);
            Console.WriteLine("Snowlight, Copyright (C) 2011 Meth0d. Available under the GNU GPL v3 license.\n");
            Console.WriteLine("This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you");
            Console.WriteLine("are welcome to redistribute it under certain conditions; please review the");
            Console.WriteLine("included LICENSE file.");
            Console.WriteLine();

            ApplyColorScheme(ConsoleColor.DarkGray);

            if (mVerbosityLevel < 0)
            {
                Console.WriteLine("* WARNING: Verbose logging is currently active. This may cause a decrease in");
                Console.WriteLine("* performance. It is recommended you set logging verbosity to 0 (Info) or higher.");
                Console.WriteLine();
            }

            ResetColorScheme();
        }

        private static string ComposeDefaultLogHeader()
        {
            StringBuilder Builder = new StringBuilder("## Snowlight" + Constants.LineBreakChar);
            Builder.Append("## Server output log file" + Constants.LineBreakChar);
            Builder.Append("## " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString() + Constants.LineBreakChar);
            Builder.Append(Constants.LineBreakChar);
            return Builder.ToString();
        }

        private static void WriteLogIfNeeded(string Line)
        {
            if (mEnableLogging)
            {
                lock (mWritebackSyncRoot)
                {
                    File.AppendAllText(mLogFilePath, FormatTimestamp() + Line + Constants.LineBreakChar,
                        Constants.DefaultEncoding);
                }
            }
        }

        public static void WriteLine()
        {
            if (mVerbosityLevel <= OutputLevel.Notification)
            {
                Console.WriteLine();
                WriteLogIfNeeded(Constants.LineBreakChar.ToString());
            }
        }

        public static void WriteLine(string Line)
        {
            WriteLine(Line, OutputLevel.Informational);
        }

        public static void WriteLine(string Line, OutputLevel Level)
        {
            if (mVerbosityLevel <= Level)
            {
                Console.Write(FormatTimestamp());
                SetColorSchemeForSeverity(Level);

                Console.WriteLine(Line);
                ResetColorScheme();

                WriteLogIfNeeded(Line);
            }
        }

        private static string FormatTimestamp()
        {
            return "[" + DateTime.Now.ToShortTimeString() + "] ";
        }

        public static void SetVerbosityLevel(OutputLevel OutputLevel)
        {
            mVerbosityLevel = OutputLevel;
        }
    }
}
