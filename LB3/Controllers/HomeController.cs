using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Mvc.Ajax;
using LB3.Models;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Xml.Serialization;


namespace LB3.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {

        DataRepository dataRepository = new DataRepository();
        private lb3dataDataContext db = new lb3dataDataContext();

        public ActionResult Years(string target)
        {
            var dataContext = new lb3dataDataContext();

            var data = from y in dataContext.Years
                      orderby y.YID descending
                       select y;

            ViewData["YearTarget"] = target;

            var cookietxt = "";

            if (target == "CourseGroups") {

               cookietxt = "Courses and Groups";

            } else if (target == "CourseHoles") {

                cookietxt = "Enter Scores";

            } else  if (target == "CourseHolesView") {

                cookietxt = "View Scores";
            }

            var histCookie = new HttpCookie("last", cookietxt);
            histCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(histCookie);

            return View("Index", data);
        }

        public ActionResult Groups(string target, int YID, int CID, string course)
        {
            var dataContext = new lb3dataDataContext();

            var data = from y in dataContext.Groups
                       where y.YearID == YID
                       where y.CourseID == CID
                       orderby y.GroupName ascending
                       select y;

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();
            
            ViewData["YID"] = YID;
            ViewData["CID"] = CID;
            ViewData["course"] = course;
            ViewData["year"] = year;

            ViewData["GroupTarget"] = target;

            string cookie = Request.Cookies["last"].Value;

            var cookietxt = cookie + ", " + year + ", " + course;

            var histCookie = new HttpCookie("last", cookietxt);
            histCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(histCookie);


            return View("Groups", data);
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Weather()
        {
            return View();
        }

        public ActionResult CourseHoles(int YID)
        {
            var dataContext = new lb3dataDataContext();
      
            var year = (from y in dataContext.Years
                       where y.YID == YID
                       select y).First().Year1.ToString();


            var data = from c in dataContext.Courses
                       where c.YID == YID
                       //orderby u.Timestamp descending
                       select c;

            ViewData["YearID"] = YID;
            ViewData["Year"] = year;

          
            return View("CourseHoles", data);
        }

        public ActionResult CourseHolesView(int YID)
        {
            var dataContext = new lb3dataDataContext();

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();


            var data = from c in dataContext.Courses
                       where c.YID == YID
                       //orderby u.Timestamp descending
                       select c;

            ViewData["YearID"] = YID;
            ViewData["Year"] = year;

            return View("CourseHolesView", data);
        }

        public ActionResult CourseGroups(int YID)
        {
            var dataContext = new lb3dataDataContext();

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();


            var data = from c in dataContext.Courses
                       where c.YID == YID
                       //orderby u.Timestamp descending
                       select c;

            ViewData["YearID"] = YID;
            ViewData["Year"] = year;

            string cookie = Request.Cookies["last"].Value;

            var cookietxt = cookie + ", " + year;

            var histCookie = new HttpCookie("last", cookietxt);
            histCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(histCookie);

            return View("CourseGroups", data);
        }

        public ActionResult Index()
        {
            
            return View("Front");
        }

     
        public ActionResult Hole(int YID, int CID, int GID, string course)
        {
            var dataContext = new lb3dataDataContext();

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();

            var group = from c in dataContext.Groups
                       where c.GID == GID
                       select c;

            var data = from c in dataContext.Holes
                       where c.CourseID == CID
                       where c.YearID == YID
                       select c;

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
                if (gpint == (grouplist.Count() -1))
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

            ViewData["YearID"] = YID;
            ViewData["Year"] = year;
            ViewData["GID"] = GID;
            ViewData["CID"] = CID;
            ViewData["course"] = course;
            ViewData["Group"] = group.First().GroupName;
            ViewData["GroupCount"] = grouplist.Count();
            ViewData["names"] = gplist;

            return View("Hole", data);
        }

        public ActionResult Events()
        {


            return View();
        }

        public ActionResult getAllEvents()
        {
            var dataContext = new lb3dataDataContext();

            var allevents = from e in dataContext.Events
                               orderby e.Timestamp descending
                               select new
                               {
                                   UserID = e.UserID,
                                   Comment = e.Comment,
                                   Name = e.Name,
                                   Timest = Convert.ToDateTime(e.Timestamp).ToShortTimeString(),
                                   EID = e.EID,
                                   type = e.Type
                               };

            return Json(new { events = allevents });
        }

        public ActionResult getLatestEvents(int EID)
        {
            var dataContext = new lb3dataDataContext();

            if (EID > 0) //not first load
            {

                var allevents = from e in dataContext.Events
                                orderby e.Timestamp descending
                                where e.EID > EID
                                select new
                                {
                                    UserID = e.UserID,
                                    Comment = e.Comment,
                                    Name = e.Name,
                                    Timest = Convert.ToDateTime(e.Timestamp).ToShortTimeString(),
                                    EID = e.EID,
                                    type = e.Type
                                };

                var speech_item = from e in dataContext.Events
                                orderby e.Timestamp descending
                                where e.EID > EID && e.Speech != null
                                select new
                                {
                                    speech = e.Speech
                                };

                if (allevents.Count() > 0)
                {

                    return Json(new { events = allevents, speech = speech_item });

                }
                else
                {
                    return Json(new { events = "none", speech = "none" });
                }

            }
            else
            {
                var allevents = from e in dataContext.Events
                                orderby e.Timestamp descending
                                where e.EID > EID
                                select new
                                {
                                    UserID = e.UserID,
                                    Comment = e.Comment,
                                    Name = e.Name,
                                    Timest = Convert.ToDateTime(e.Timestamp).ToShortTimeString(),
                                    EID = e.EID,
                                    type = e.Type
                                };

                var speech_item = from e in dataContext.Events
                                  orderby e.Timestamp descending
                                  where e.EID > EID && e.Speech != null
                                  select new
                                  {
                                      speech = e.Speech
                                  };

                return Json(new { events = allevents.Take(1), speech = speech_item.Take(1)});
            }
        }

        public ActionResult CourseDetails(int CID, int YID, string course)
        {
            var dataContext = new lb3dataDataContext();

            var data = from c in dataContext.Holes
                       where c.CourseID == CID
                       where c.YearID == YID
                       orderby c.HoleNum ascending
                       select c;

            var data_group = from c in dataContext.Groups
                       where c.CourseID == CID
                       where c.YearID == YID
                       //orderby u.Timestamp descending
                       select c;

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();

            ViewData["Course"] = course;

            ViewData["Year"] = year;
            ViewData["Holes"] = data;
            ViewData["Groups"] = data_group;
            ViewData["CourseID"] = CID;
            ViewData["YID"] = YID;

            var userList = (from u in dataContext.Users
                            orderby u.Name ascending

                            select new
                            {
                                name = u.Name,
                                id = u.UserID,

                            }).ToArray();

            var dd_items = "";

            dd_items = "<option>Select User</option>";

            foreach (var item in userList)
            {
                dd_items = dd_items + "<option value=" + item.id + ">" + item.name + "</option>";
            }

            ViewData["dd_vals"] = dd_items;

            string cookie = Request.Cookies["last"].Value;

            var cookietxt = cookie + ", " + year + ", " + course;

            var histCookie = new HttpCookie("last", cookietxt);
            histCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(histCookie);

            return View("CourseDetails");
        }

        public ActionResult ScoreDetails(int GID, string course, int YID, int CID)
        {
            var dataContext = new lb3dataDataContext();

            ViewData["YID"] = YID;
            ViewData["Course"] = course;
            ViewData["GID"] = GID;
            ViewData["CID"] = CID;

            var group = from c in dataContext.Groups
                        where c.GID == GID
                        select c;

            ViewData["Group"] = group.First().GroupName;

            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();

            ViewData["Year"] = year;

            var data = from c in dataContext.Groups
                       where c.GID == GID
                       select c;

            var data2 = from c in dataContext.Holes
                       where c.CourseID == data.First().CourseID
                       where c.YearID == data.First().YearID
                       orderby c.HoleNum ascending
                       select c;

            ViewData["HID"] = data2.First().HoleID;

            var userList = (from u in dataContext.UserGroups
                            where u.GID == GID
                            orderby u.User.Nickname ascending

                            select new
                            {
                                name = u.User.Nickname,
                                id = u.UserID,

                            }).ToArray();

            var dd_items = "";

            dd_items = "<option>Select User</option>";

            foreach (var item in userList)
            {
                dd_items = dd_items + "<option value=" + item.id + ">" + item.name + "</option>";
            }

            ViewData["dd_vals"] = dd_items;


            //topqa_ad.Union(topqa.Take(5 - admin_ct)).OrderBy(t => t.Marks.First().Timestamp);
            return View("ScoreDetails");
        }

        public ActionResult CourseCard(int CID, int YID, string course, int GID)
        {
            var dataContext = new lb3dataDataContext();
            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();
            ViewData["Course"] = course;
            ViewData["Year"] = year;

            var data = from c in dataContext.UserGroups
                       where c.GID == GID
                     
                       //orderby u.Timestamp descending
                       select c;

            var hole_data = from c in dataContext.Courses
                       where c.CID == CID
                       where c.YID == YID

                       //orderby u.Timestamp descending
                       select c;

            ViewData["Card"] = data;
            ViewData["holes"] = hole_data;

            return View("CourseCard");
        }

        public ActionResult HoleCard(int CID, int YID, string course, int GID, int HoleID)
        {
            var dataContext = new lb3dataDataContext();
            var year = (from y in dataContext.Years
                        where y.YID == YID
                        select y).First().Year1.ToString();

            var hole = from h in dataContext.Holes
                       where h.HoleID == HoleID
                       select h;

            var par = hole.First().Par;

            var HoleNum = hole.First().HoleNum;
            

            
            try
            {
                var nexthole = from h in dataContext.Holes
                               where h.HoleNum == HoleNum + 1
                               where h.YearID == YID
                               where h.CourseID == CID
                               select h;
                var NextHoleID = nexthole.First().HoleID;
                ViewData["NextHoleID"] = NextHoleID;

                ViewData["NextHole"] = HoleNum + 1;
            }
            catch
            {
                ViewData["NextHoleID"] = null;
            }
            ViewData["Course"] = course;
            ViewData["Year"] = year;
            ViewData["HID"] = HoleID;
            ViewData["GID"] = GID;
            ViewData["CID"] = CID;
            ViewData["YID"] = YID;
            ViewData["HoleNum"] = HoleNum;
            ViewData["Par"] = par;
            
            var pin = (from p in dataContext.Holes
                               where p.HoleID == HoleID
                               select p.N_pin).First();

            ViewData["Pin"] = pin;

            var ld = (from p in dataContext.Holes
                                  where p.HoleID == HoleID
                                  select p.L_drive).First();

            ViewData["LD"] = ld;

            if (pin == 1)
            {
                 
                try
                {
                    var pinuser = (from p in dataContext.Scores
                                   where p.HoleID == HoleID
                                   where p.PinUserID != null
                                   select p.PinUserID).First();
                    if (pinuser == null)
                        {
                            ViewData["PinUser"] = 0;
                        }
                        else
                        {
                            ViewData["PinUser"] = pinuser;
                    }
                }
                catch
                {

                }
                
            }

            if (ld == 1)
            {

                try
                {
                    var lduser = (from p in dataContext.Scores
                                   where p.HoleID == HoleID
                                   where p.DriveUserID != null
                                  select p.DriveUserID).First();
                    if (lduser == null)
                    {
                        ViewData["LDUser"] = 0;
                    }
                    else
                    {
                        ViewData["LDUser"] = lduser;
                    }
                }
                catch
                {

                }

            }
            
            var data = from c in dataContext.UserGroups
                       where c.GID == GID
                       select c;

          
          

            return View("HoleCard", data);
        }


        //public ActionResult HolePartialEdit(int HoleID)
       // {
       //     var dataContext = new lb3dataDataContext();

       //     Hole hole = dataRepository.GetHole(HoleID);

       //     return PartialView("HolePartialEdit", hole);
       // }

        public PartialViewResult HolePartialNew(int CID, int YID)
        {
            var dataContext = new lb3dataDataContext();
            int next = 1;
            try
            {

                var data = from c in dataContext.Holes
                           where c.CourseID == CID
                           where c.YearID == YID
                           orderby c.HoleNum descending
                           select c;

                next = Convert.ToInt32(data.First().HoleNum) + 1;
            }
            catch
            {
               
            }
            //Hole hole = dataRepository.GetHole(HoleID);
            ViewData["CID"] = CID;
            ViewData["YID"] = YID;
            ViewData["NextNum"] = next;
            return PartialView("HolePartialNew");
        }

       
        public ActionResult saveHole(int CID, int YID, int holeNum, int par, int SIndx, string pin_v, string drive_v)
        {
            var dataContext = new lb3dataDataContext();

            var pin = 0;
            var drive = 0;

            if (pin_v == "true")
            {
                pin = 1;
            }

            if (drive_v == "true")
            {
                drive = 1;
            }
            Hole hole = new Hole();
            hole.HoleNum = holeNum;
            hole.Par = par;
            hole.CourseID = CID;
            hole.YearID = YID;
            hole.SI = SIndx;
            hole.N_pin = pin;
            hole.L_drive = drive;

            dataRepository.Add(hole);
            dataRepository.Save();

            var data = from c in dataContext.Holes
                       where c.CourseID == CID
                       where c.YearID == YID
                       orderby c.HoleNum ascending
                       select c;
            ViewData["CourseID"] = CID;
            ViewData["YID"] = YID;
            ViewData["NextNum"] = holeNum + 1;
            ViewData["coll"] = "data-collapsed=\"false\"";
            return PartialView("HolePartial", data);

        }

        public void deleteHole(int HID)
        {
            dataRepository.DeleteHole(HID);
        }

        public PartialViewResult GroupPartialNew(int CID, int YID)
        {
            var dataContext = new lb3dataDataContext();

            //Hole hole = dataRepository.GetHole(HoleID);
            ViewData["CID"] = CID;
            ViewData["YID"] = YID;
            return PartialView("GroupPartialNew");
        }

        public ActionResult saveGroup(int CID, int YID, string groupname)
        {
            var dataContext = new lb3dataDataContext();
            //gp
            LB3.Models.Group group = new LB3.Models.Group();
            group.GroupName = groupname;
            group.CourseID = CID;
            group.YearID = YID;

            dataRepository.Add(group);
            dataRepository.Save();

            var data = from c in dataContext.Groups
                       where c.CourseID == CID
                       where c.YearID == YID
                       //orderby u.Timestamp descending
                       select c;

            return PartialView("GroupPartial", data);

        }

        public PartialViewResult PlayerPartialNew(int GID)
        {
            var dataContext = new lb3dataDataContext();

            var userList = (from u in dataContext.Users
                              orderby u.Name ascending

                              select new
                              {
                                  name = u.Name,
                                  id = u.UserID,

                              }).ToArray();

            var dd_items = "";

            dd_items = "<option>Select User</option>";

            foreach (var item in userList)
            {
                dd_items = dd_items + "<option value=" + item.id + ">" + item.name + "</option>";
            }

            ViewData["dd_vals"] = dd_items;

            //Hole hole = dataRepository.GetHole(HoleID);
            ViewData["GID"] = GID;

            return PartialView("PlayerPartialNew");
        }

        public ActionResult savePlayer(int GID, int UserID)
        {
            var dataContext = new lb3dataDataContext();
            //gp
            UserGroup ug = new UserGroup();
            ug.GID = GID;
            ug.UserID = UserID;

            dataRepository.Add(ug);
            dataRepository.Save();

            var data = from c in dataContext.UserGroups                      
                       where c.GID == GID
                       //orderby u.Timestamp descending
                       select c;
            ViewData["GID"] = GID;

            var userList = (from u in dataContext.Users
                            orderby u.Name ascending

                            select new
                            {
                                name = u.Name,
                                id = u.UserID,

                            }).ToArray();

            var dd_items = "";

            dd_items = "<option>Select User</option>";

            foreach (var item in userList)
            {
                dd_items = dd_items + "<option value=" + item.id + ">" + item.name + "</option>";
            }

            ViewData["dd_vals"] = dd_items;

            return PartialView("PlayersPartial", data);

        }

        public ActionResult removePlayer(int GID, int UserID)
        {
            var dataContext = new lb3dataDataContext();

            dataRepository.RemovePlayer(GID,UserID);            
           
            var data = from c in dataContext.UserGroups
                       where c.GID == GID
                       //orderby u.Timestamp descending
                       select c;

            ViewData["GID"] = GID;

            var userList = (from u in dataContext.Users
                            orderby u.Name ascending

                            select new
                            {
                                name = u.Name,
                                id = u.UserID,

                            }).ToArray();

            var dd_items = "";

            dd_items = "<option>Select User</option>";

            foreach (var item in userList)
            {
                dd_items = dd_items + "<option value=" + item.id + ">" + item.name + "</option>";
            }

            ViewData["dd_vals"] = dd_items;

            return PartialView("PlayersPartial", data);

        }

        public ActionResult getScore(int HID, int UserID, int GID)
        {
            var dataContext = new lb3dataDataContext();
            //gp
            
            var data = from c in dataContext.Scores
                       where c.HoleID == HID
                       where c.UserID == UserID
                       //orderby u.Timestamp descending
                       select c;
            ViewData["HID"] = HID;
            ViewData["GID"] = GID;
            ViewData["UserID"] = UserID;
            return PartialView("ScorePartial", data);

        }

        public JsonResult newScore(int GID, int YID, int HID, int UserID, int score, int Pin, int LD)
        {
            var dataContext = new lb3dataDataContext();
           
            var otherplayers = from users in dataContext.UserGroups
                               where users.GID == GID
                               where users.UserID != UserID
                               select new
                               {
                                   UserID = users.UserID
                               };

            var winner = from users in dataContext.Users
                               where users.UserID == UserID
                               select users;


            var ck_score = from s in dataContext.Scores
                     where s.YearID == YID
                     where s.UserID == UserID
                     where s.HoleID == HID
                     select s;

            var ck_pin = from s in dataContext.Scores
                           where s.YearID == YID
                           where s.PinUserID == UserID
                           where s.HoleID == HID
                           select s;

            var ck_LD = from s in dataContext.Scores
                         where s.YearID == YID
                         where s.DriveUserID == UserID
                         where s.HoleID == HID
                         select s;
            var type = "";
            if (ck_score.Count() == 1 || ck_pin.Count() == 1 || ck_LD.Count() == 1)
            {
                //update stuff
                type = "Updated";
                if (score > 0)
                {
                    dataRepository.UpdateScore(ck_score.First().ScID, score);
                }
                else
                {
                    if (Pin == 1)
                    {
                        dataRepository.ResetPin(YID, HID);
                        dataRepository.UpdatePin(ck_score.First().ScID, UserID);
                        dataRepository.CheckScorePLD(HID, UserID, "Pin");
                    }

                    if (LD == 1)
                    {
                        dataRepository.ResetLD(YID, HID);
                        dataRepository.UpdateLD(ck_score.First().ScID, UserID);
                        dataRepository.CheckScorePLD(HID, UserID, "LD");
                    }
                
                }
            }
            else
            {
                //insert stuff
                type = "Saved";
                if (Pin == 1)
                {
                    dataRepository.ResetPin(YID, HID);
                    Score sc = new Score();
                    sc.PinUserID = UserID;
                    sc.UserID = UserID;
                    sc.YearID = YID;
                    sc.HoleID = HID;
                    dataRepository.Add(sc);
                    dataRepository.Save();
                    dataRepository.CheckScore(0, GID, YID, HID, UserID);
                    dataRepository.CheckScorePLD(HID, UserID, "Pin");
                }
                else if (LD == 1)
                {
                    dataRepository.ResetLD(YID, HID);
                    Score sc = new Score();
                    sc.DriveUserID = UserID;
                    sc.UserID = UserID;
                    sc.YearID = YID;
                    sc.HoleID = HID;
                    dataRepository.Add(sc);
                    dataRepository.Save();
                    dataRepository.CheckScore(0, GID, YID, HID, UserID);
                    dataRepository.CheckScorePLD(HID, UserID, "LD");
                }
                else
                {
                    Score sc = new Score();
                    sc.HoleID = HID;
                    sc.YearID = YID;
                    sc.UserID = UserID;
                    sc.Score1 = score;

                    dataRepository.Add(sc);
                    dataRepository.Save();
                    dataRepository.CheckScore(0, GID, YID, HID, UserID);

                   
                }
            }
            if (type == "Saved")
            {
                return Json(new { members = otherplayers, winner = winner.First().Nickname, type = "Saved" });
            }
            else
            {
                return Json(new { members = otherplayers, winner = winner.First().Nickname, type = "Updated" });
            }
        }

        public ActionResult YearGroups(int YID)
        {
            var dataContext = new lb3dataDataContext();

            var data = from y in dataContext.Groups
                       where y.YearID == YID
                       //orderby u.Timestamp descending
                       select y;

            //var message = Convert.ToString(data.First().Timestamp) + ": " + data.First().Comment;

            return View();
        }

       
    }
}
