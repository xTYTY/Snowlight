using System;

namespace Snowlight.Util
{
    public static class UserInputFilter
    {
        public static string FilterString(string Input, bool PermitLineBreaks = false)
        {
            Input = Input.Trim();
            Input = Input.Replace(Convert.ToChar(1), ' ');
            Input = Input.Replace(Convert.ToChar(2), ' ');
            Input = Input.Replace(Convert.ToChar(3), ' ');
            Input = Input.Replace(Convert.ToChar(9), ' ');

            if (!PermitLineBreaks)
            {
                Input = Input.Replace(Convert.ToChar(10), ' ');
                Input = Input.Replace(Convert.ToChar(13), ' '); 
            }

            return Input;
        }
    }
}
