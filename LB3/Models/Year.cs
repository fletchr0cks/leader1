using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LB3.Models
{
    public partial class Year
    {
        private lb3dataDataContext db = new lb3dataDataContext();

        public int PlayerCountforTourn(int YID)
        {

            var players = from y in db.Users
                          join g in db.UserGroups on y.UserID equals g.UserID
                          where g.Group.YearID == YID
                          //join g in db.UserGroups where g.UserID equals y.
                          //where y.UserGroups.Any().Equals. == YID
                          select y;

            return players.Count();

       
        }

     }
}
