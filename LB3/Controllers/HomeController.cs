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
using Newtonsoft.Json;
using Newtonsoft.Json.Utilities;
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json.Linq;

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

            ViewData["YearTarget"] = target;
            

            return View("Index", data);
        }

        public ActionResult Offline()
        {
            return View();
        }

        public ActionResult CacheTest()
        {
            Response.Cache.SetCacheability(
                System.Web.HttpCacheability.NoCache);
            return View();
        }

        public ActionResult Manifesto()
        {
            Response.ContentType = "text/cache-manifest";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Cache.SetCacheability(
                System.Web.HttpCacheability.NoCache);
            return View();
        }

        public ActionResult Manifest()
        {
            var manifest = "CACHE MANIFEST" + Environment.NewLine +
                  //"# App Markup Date: " + DateTime.UtcNow + Environment.NewLine +
                  "# Server Assembly Version: " + this.GetType().Assembly.GetName().Version + Environment.NewLine +
                  "NETWORK:" + Environment.NewLine +
                  "*" + Environment.NewLine +
                  "CACHE:" + Environment.NewLine +
                  //Url.Action("Index", "Home") + Environment.NewLine +
                  Url.Content("~/Content/jquery.mobile-1.1.0.css") + Environment.NewLine +
                  Url.Content("~/Scripts/jquery-1.6.4.js") + Environment.NewLine +
                  Url.Content("~/Scripts/modernizr-dev.js") + Environment.NewLine +
                  Url.Content("~/Scripts/jquery-mobile-1.1.0.js") + Environment.NewLine +
                  Url.Content("~/Home/Offline") + Environment.NewLine +
                  Url.Content("~/Home/LocalHoleCard") + Environment.NewLine +
                  Url.Content("~/Home/HoleLocal") + Environment.NewLine +
                  Url.Content("~/Content/images/21.png") + Environment.NewLine +
                  Url.Content("~/Home/CacheTest") + Environment.NewLine +
                  //Url.Content("~/Home/CacheTest") + Environment.NewLine +
                  "FALLBACK:" + Environment.NewLine +
                  Url.Content("/") + " " + Url.Content("/Home/HoleLocal");

            return Content(manifest, "text/cache-manifest");
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

            //string cookie = Request.Cookies["last"].Value;

            //var cookietxt = cookie + ", " + year + ", " + course;

            //var histCookie = new HttpCookie("last", cookietxt);
            //histCookie.Expires = DateTime.Now.AddDays(1);
            //Response.AppendCookie(histCookie);


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


            return View("CourseGroups", data);
        }

        public ActionResult Index()
        {
            var dataContext = new lb3dataDataContext();

            var data = from c in dataContext.Events
                       //where c.CourseID == CID
                       orderby c.Timestamp descending
                        select c;

            ViewData["Holes"] = data.Take(1);

            return View("Front");
        }

        public ActionResult HoleLocal()
        {

            return View();
        }

        public ActionResult ClearScores(int YID)
        {
            var dataContext = new lb3dataDataContext();

            dataRepository.DeleteScores(YID);

            return Json(new { scores = "deleted" });
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

            var holedataJ = from c in dataContext.Holes
                            where c.CourseID == CID
                            where c.YearID == YID
                            select new
                            {
                                HoleID = c.HoleID,
                                HoleNum = c.HoleNum,
                                HolePin = c.N_pin,
                                HoleLD = c.L_drive,
                                Par = c.Par
                                //Scre = (from s in dataContext.Scores where s.HoleID == c.HoleID && s.UserID == user
                            };

            var scoredataJ = from c in dataContext.Scores                          
                            where c.YearID == YID
                            select new
                            {
                                UserID = c.UserID,
                                Score = c.Score1,
                                HID = c.HoleID,
                                ScoreID = c.ScID
                            };

            var grouplistJ = from y in db.UserGroups
                            where y.GID == GID
                            select new
                            {
                                Nickname = y.User.Nickname,
                                UserID = y.UserID
                               
                            };

            var grouplist = from y in db.UserGroups
                            where y.GID == GID
                            select new
                            {
                                name = y.User.Nickname
                                
                            };

            var gplist = "";
            int gpint = 0;

            System.Collections.Generic.List<string> UserArray = new System.Collections.Generic.List<string>();

            foreach (var sc in grouplist)
            {
                //UserArray.Add(sc.name);
                //UserArray.Add(Convert.ToString(sc.userid));

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

           
                var nexthole = from h in dataContext.Holes
                               where h.HoleNum == 1
                               where h.YearID == YID
                               where h.CourseID == CID
                               select h;
                var NextHoleID = nexthole.First().HoleID;




            string jsonUsers = JsonConvert.SerializeObject(grouplistJ.ToArray());
            string jsonHoleData = JsonConvert.SerializeObject(holedataJ.ToArray());
            string jsonScoreData = JsonConvert.SerializeObject(scoredataJ.ToArray());

            ViewData["YearID"] = YID;
            ViewData["Year"] = year;
            ViewData["GID"] = GID;
            ViewData["CID"] = CID;
            ViewData["course"] = course;
            ViewData["Group"] = group.First().GroupName;
            ViewData["GroupCount"] = grouplist.Count();
            ViewData["names"] = gplist;
            ViewData["NextHoleID"] = NextHoleID;
            ViewData["HoleCount"] = data.Count();
            ViewData["JSONnames"] = jsonUsers;
            ViewData["JSONHoleData"] = jsonHoleData;
            ViewData["JSONScoreData"] = jsonScoreData;

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

        public ActionResult LocalHoleCard()
        {


            return View();
        } 

        public ActionResult getLatestEvents(int EID)
        {
            var dataContext = new lb3dataDataContext();

          //  if (EID > 0) //not first load
       //     {

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

              //  if (allevents.Count() > 0)
              //  {

                return Json(new { events = allevents.Take(2), speech = speech_item.Take(2) }, JsonRequestBehavior.AllowGet);

             //   }
             //   else
            //    {
            //        return Json(new { events = "none", speech = "none" }, JsonRequestBehavior.AllowGet);
            //    }

         //   }
         //   else
         ///   {
               

           //     return Json(new { events = "none" }, JsonRequestBehavior.AllowGet);
          //  }
        }

        public ActionResult CourseUA()
        {
             var dataContext = new lb3dataDataContext();
             var courseUA = from c in dataContext.CourseUAs
                            orderby c.CourseName
                            select c;

            return View("CourseUA", courseUA);
        }

        public ActionResult ViewCourseUA()
        {
            var dataContext = new lb3dataDataContext();
            var courseUA = from c in dataContext.CourseUAs
                           orderby c.CourseName
                           select c;

            return View("ViewCourseUA", courseUA);
        }

       
        public ActionResult AddCourseUA()
        {
            
           return View();

        }

        public ActionResult AddTourn()
        {

            return View();

        }

        [HttpPost]
        public ActionResult AddTourn(FormCollection formCollection)
        {
            var TournName = formCollection["Name"];
            DateTime Date = Convert.ToDateTime(formCollection["Date"]);
            int Yr = Date.Year;
            int newYID = dataRepository.SaveNewTourn(TournName, Date, Yr);
            return RedirectToAction("CourseUA", new { id = newYID }); //courseholes to edit drive and pin
            // return View();
        }

        [HttpPost]
        public ActionResult AddCourseUA(FormCollection formCollection)
        {
            var CourseName = formCollection["CourseName"];
            int Stable = Convert.ToInt32(formCollection["Stableford_Total"]);
            int newCID = dataRepository.SaveNewCourse(CourseName, Stable);
            return RedirectToAction("AddCourseUAHoles", new { id = newCID, CourseName = CourseName });
           // return View();
        }

       
        public ActionResult AddCourseUAholes(int id, string CourseName)
        {
            var dataContext = new lb3dataDataContext();

            var data = from c in dataContext.HoleUAs
                       where c.CourseUAID == id                     
                       orderby c.HoleNum ascending
                       select c;
            ViewData["CourseName"] = CourseName;
            ViewData["UAHoles"] = data;

            ViewData["CUAID"] = id;

            return View("AddCourseUAholes");
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

        public PartialViewResult HoleUAPartialNew(int CUAID)
        {
            var dataContext = new lb3dataDataContext();
            int next = 1;
            try
            {

                var data = from c in dataContext.HoleUAs                          
                           orderby c.HoleNum descending
                           where c.CourseUAID == CUAID
                           select c;

                next = Convert.ToInt32(data.First().HoleNum) + 1;
            }
            catch
            {

            }
            //Hole hole = dataRepository.GetHole(HoleID);
            ViewData["CUAID"] = CUAID;
            ViewData["NextNum"] = next;
            return PartialView("HoleUAPartialNew");
        }


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

      
        public PartialViewResult EventsPartial2()
        {
            var dataContext = new lb3dataDataContext();

            var data = from c in dataContext.Events
                       //where c.CourseID == CID
                       orderby c.Timestamp descending
                       select c;

            return PartialView("EventsPartial2", data.Take(1));
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

        public ActionResult saveUAHole(int CUAID, int holeNum, int par, int SIndx)
        {
            var dataContext = new lb3dataDataContext();

            HoleUA hole = new HoleUA();
            hole.CourseUAID = CUAID;
            hole.HoleNum = holeNum;
            hole.Par = par;           
            hole.SI = SIndx;

            dataRepository.Add(hole);
            dataRepository.Save();

            var data = from c in dataContext.HoleUAs
                       where c.CourseUAID == CUAID                   
                       select c;            
            ViewData["NextNum"] = holeNum + 1;
            ViewData["coll"] = "data-collapsed=\"false\"";
            ViewData["CUAID"] = CUAID;
            return PartialView("HoleUAPartial", data);

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

        public ActionResult EventsFeed() //used
        {
            var dataContext = new lb3dataDataContext();
             
            var allevents = from e in dataContext.Events
                            orderby e.Timestamp descending
                            select e;

           

            return PartialView("EventsPartial", allevents.Take(1));
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

        public ActionResult Users()
        {

            return View();
        }

        public JsonResult getMiniLB(int CID, int YID, int HoleNum)
        {
            var dataContext = new lb3dataDataContext();
            //gp
            var miniLBdata = from r in dataContext.Scores
                            where r.Hole.CourseID == CID
                            where r.YearID == YID
                       orderby r.Score1 descending
                       group r by new { 
                           r.User.Nickname,
                           //r.Hole.CourseID,
                          // r.Hole.Par
                          // r.Description
                       } into g
                       orderby g.Sum(s => s.Score1)
                     
                       select new {
                              //g.Key..Category,
                              g.Key.Nickname,
                              TotalScore = g.Sum(x => x.Score1),
                              //CID = g.Key.CourseID,
                              Pars = g.Sum(x => x.Hole.Par),
                             
                              //get sum of all completed holes for pars
                             
                        };

         //take sum of scores

            return Json(new { miniLBdata });

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

            var HoleData = from h in dataContext.Holes
                           where h.HoleID == HID
                           select h;

            var HoleNum = HoleData.First().HoleNum;

            var CID = HoleData.First().CourseID;

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
                return Json(new { members = otherplayers, winner = winner.First().Nickname, type = "Saved to server", HoleNum = HoleNum, CID = CID, YID = YID });
            }
            else
            {
                return Json(new { members = otherplayers, winner = winner.First().Nickname, type = "Updated to server", HoleNum = HoleNum, CID = CID, YID = YID });
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
