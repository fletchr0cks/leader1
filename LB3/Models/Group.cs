using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LB3.Models
{
    public partial class Group
    {
        private lb3dataDataContext db = new lb3dataDataContext();

        public string GetNamesForGroup(int GID)
        {

            var grouplist = from y in db.UserGroups
                           where y.GID == GID
                            select new
                            {
                                name = y.User.Nickname
                            };

            var gplist = "";
            int gpint = 0;

            foreach (var sc in grouplist)
            {
                if (gpint == 3)
                {
                    gplist = gplist + " and " + sc.name;
                }
                else if (gpint == 0)
                {
                    gplist = sc.name;
                }

                else
                {
                    gplist = gplist + ", " + sc.name;
                }

                gpint++;
            }

            return gplist;
        }

     }
}
