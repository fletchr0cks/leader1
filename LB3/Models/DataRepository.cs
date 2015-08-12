using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Timers;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using LB3.Models;
using System.IO;

namespace LB3.Models
{
    public class DataRepository
    {
        private lb3dataDataContext db = new lb3dataDataContext();

        Timer myTimer = new Timer();
        Timer myTimerPLD = new Timer();

        public void UpdateScore(int ScoreID, int score)
        {
            var sc = db.Scores
                .Where(s => s.ScID == ScoreID)
                .First();

            sc.Score1 = score;
            db.SubmitChanges();

            CheckScore(ScoreID, 0, 0, 0, 0);

        }

        public void InitTimerScore(int ScoreID, int GID, int YID, int HID, int UserID)
        {
            myTimer.AutoReset = false;
            
         myTimer.Elapsed += delegate { CheckScore(ScoreID,GID,YID,HID,UserID); };
            myTimer.Interval = 8000;
            myTimer.Start();

        }

        public void InitTimerPLD(int HID, int UserID, string type)
        {
            myTimerPLD.AutoReset = false;

            myTimerPLD.Elapsed += delegate { CheckScorePLD(HID, UserID, type); };
            myTimerPLD.Interval = 8000;
            myTimerPLD.Start();

        }

       

        public void CheckScore(int ScoreID, int GID, int YID, int HID, int UserID)
        {

            if (ScoreID == 0)
            {

                var scores = from s in db.Scores
                             where s.HoleID == HID
                             where s.YearID == YID
                             select s;

                var score_ct = scores.Count();

                var hole = from c in db.Holes
                           where c.HoleID == HID
                           select c;

                int par = Convert.ToInt32(hole.First().Par);

                var courseID = hole.First().CourseID;

                var course = from c in db.Courses
                             where c.CID == courseID
                             select c;

                var courseName = course.First().CourseName;

                var holeNum = hole.First().HoleNum;

                var nextHoleNum = hole.First().HoleNum + 1;

                var nextHole = from c in db.Holes
                               where c.HoleNum == nextHoleNum
                               where c.CourseID == courseID
                               where c.YearID == YID
                               select c;

                var grouplist = from y in db.UserGroups
                                where y.GID == GID
                                select y;

                var nextCmt = "";
                var nextType = "";

                try
                {

                    if (nextHoleNum == 18)
                    {
                        nextCmt = "are on to the 18th at " + courseName + ", closing out their day.";
                    }

                    else if (nextHole.First().L_drive == 1)
                    {
                        nextCmt = "are about to tee off on their Longest Drive hole (" + nextHoleNum + ").";
                        nextType = "Drive";
                    }
                    else if (nextHole.First().N_pin == 1)
                    {
                        nextCmt = "are about to tee off on their Nearest The Pin hole (" + nextHoleNum + ").";
                        nextType = "Pin";
                    }
                    else
                    {
                        nextCmt = "are on to hole " + nextHoleNum + " at " + courseName + ".";
                    }

                }
                catch
                {

                }

          

                //myTimer.Stop();

                if (score_ct == grouplist.Count()) //all scores are done for the hole
                {
                    var ev_scores = from s in db.Scores
                                    where s.HoleID == HID
                                    where s.YearID == YID
                                    orderby s.Score1 ascending
                                    select new
                                    {
                                       name = s.User.Nickname,
                                       score = Convert.ToInt32(s.Score1)

                                    };
                    var comts = "";
                    var gplist = "";
                    
                    int gpint = 0;
                    int scint = 0;
                    //ev_scores.OrderBy(u => u.score);

                    foreach (var sc in ev_scores) {
                        var sctype = "";
                        var speech = "";
                        if (sc.score == par)
                        {
                            sctype = "Par";
                        }
                        else if (sc.score < par)
                        {
                            if (sc.score == (par - 1))
                            {
                                //birdie
                                sctype = "<strong>Birdie</strong>";
                                speech = sc.name.First() + " scored a birdie on hole " + hole.First().HoleNum;
                            }

                            else if (sc.score == (par - 2))
                            {
                                //eagle
                                sctype = "<strong>eagle</strong>";
                                speech = sc.name.First() + " scored an eagle on hole " + hole.First().HoleNum;
                            }
                        }

                        if (sc.score == 1)
                        {
                            sctype = "<strong>HOLE IN ONE!!!</strong>";
                        }

                        if (scint == 0)
                        {
                            comts = sc.name + ": " + sc.score + " (" + sctype + ")";
                        }
                        else if (scint == (grouplist.Count() - 1))
                        {
                            comts = comts + sc.name + " : " + sc.score + " (" + sctype + ")";
                        }
                        else
                        {
                            comts = comts + sc.name + " : " + sc.score;
                        }
                        scint++;
                    }

                    foreach (var sc in ev_scores)
                    {
                        if (gpint == (grouplist.Count() - 1))
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

                    Event e = new Event();
                    e.Timestamp = DateTime.Now;
                    e.Name = "Hole: " + holeNum + ", Par: " + par;
                    e.Comment = comts;                 
                    Add(e);
                    Save();

                    if (nextCmt.Length > 5)
                    {

                        Event e2 = new Event();
                        e2.Timestamp = DateTime.Now;
                        e2.Name = gplist;
                        e2.Comment = nextCmt;
                        e2.Type = nextType;
                        Add(e2);
                        Save();

                    }
                }
                                

            } else {
                    var score = from s in db.Scores
                                 where s.ScID == ScoreID
                                 select s;

                    var grouplist = from y in db.UserGroups
                                    where y.GID == GID
                                    select y;

                    HID = Convert.ToInt32(score.First().HoleID);
                    YID = Convert.ToInt32(score.First().YearID);

                    var scores = from s in db.Scores
                                 where s.HoleID == HID
                                 where s.YearID == YID
                                 select s;

                    var score_ct = scores.Count();

                    var hole = from c in db.Holes
                               where c.HoleID == HID
                               select c;
                    int par = Convert.ToInt32(hole.First().Par);
                    var courseID = hole.First().CourseID;

                    var holeNum = hole.First().HoleNum;

                    var course = from c in db.Courses
                                 where c.CID == courseID
                                 select c;

                    //myTimer.Stop();

                    if (score_ct == grouplist.Count())
                    {

                         var ev_scores = from s in db.Scores
                                    where s.ScID == ScoreID
                                    select new
                                    {
                                       name = s.User.Nickname,
                                       score = Convert.ToInt32(s.Score1)

                                    };
                    var comts = "";
                    //ev_scores.OrderBy(u => u.score);

                    foreach (var sc in ev_scores) {
                        comts = comts + sc.name + ": " + sc.score;
                    }


                        Event e = new Event();
                        e.Timestamp = DateTime.Now;
                        e.Name = course.First().CourseName + ", Hole " + holeNum + ", Par: " + par;
                        e.Comment = "Modified. " + comts;


                        Add(e);
                        Save();

                    }

            }


                }
        public void CheckScorePLD(int HID, int UserID, string type)
        {
            
            var hole = from c in db.Holes
                       where c.HoleID == HID
                       select c;

            var courseID = hole.First().CourseID;

            var holeNum = hole.First().HoleNum;

            var course = from c in db.Courses
                         where c.CID == courseID
                         select c;

            var user = from c in db.Users
                         where c.UserID == UserID
                         select c;

            

            if (type == "Pin")
            {
                Event e = new Event();
                e.Timestamp = DateTime.Now;
                e.Name = course.First().CourseName + ", Hole " + holeNum;
                e.Comment = user.First().Nickname + " was nearest the pin";
                e.UserID = UserID;
                e.Speech = user.First().Nickname + "nearest the pin for group" + user.First().UserGroups.First().Group + "was" + user.First().Nickname;
                Add(e);
                Save();
            }
            else
            {
                Event e = new Event();
                e.Timestamp = DateTime.Now;
                e.Name = course.First().CourseName + ", Hole " + holeNum;
                e.Comment = user.First().Nickname + " had the longest drive";
                e.Speech = user.First().Nickname + "longest drive for group" + user.First().UserGroups.First().Group + "was" + user.First().Nickname;
                e.UserID = UserID;
                Add(e);
                Save();
            }


        }

        

        public void UpdatePin(int ScoreID, int pinuserid)
        {

            var sc = db.Scores
                .Where(s => s.ScID == ScoreID)
                .First();

            sc.PinUserID = pinuserid;
            db.SubmitChanges();
        }

        public int SaveNewCourse(string name, int stable)
        {         
            DataRepository dataRepository = new DataRepository();
            CourseUA course = new CourseUA();
            course.CourseName = name;
            course.Stableford_Total = stable;
            int CID = dataRepository.Add(course);
            return CID;            
        }

        public int SaveNewTourn(string name, DateTime date, int yr)
        {
            DataRepository dataRepository = new DataRepository();
            CourseUA course = new CourseUA();
            course.CourseName = name;
            course.Stableford_Total = 5;
            int CID = dataRepository.Add(course);
            return CID;
        }

        public void ResetPin(int YID, int HID)
        {
            try
            {
                var sc = db.Scores
                    .Where(s => s.HoleID == HID)
                    .Where(s => s.YearID == YID)
                    .Where(s => s.PinUserID != null)
                    .First();

                sc.PinUserID = null;
                db.SubmitChanges();
            }
            catch
            {

            }
        }

        public void UpdateLD(int ScoreID, int LDuserid)
        {
            var sc = db.Scores
                .Where(s => s.ScID == ScoreID)
                .First();

            sc.DriveUserID = LDuserid;
            db.SubmitChanges();
        }

        public void ResetLD(int YID, int HID)
        {
            try
            {
                var sc = db.Scores
                    .Where(s => s.HoleID == HID)
                    .Where(s => s.YearID == YID)
                    .Where(s => s.DriveUserID != null)
                    .First();

                sc.DriveUserID = null;
                db.SubmitChanges();
            }
            catch
            {

            }
        }

        public void DeleteHole(int HID)
        {
            var hole = db.Holes
                       .Where(h => h.HoleID == HID)
                       .First();

            db.Holes.DeleteOnSubmit(hole);
            db.SubmitChanges();
        }

        public void RemovePlayer(int GID, int UserID)
        {
            var hole = db.UserGroups
                       .Where(h => h.GID == GID)
                       .Where(h => h.UserID == UserID)
                       .First();

            db.UserGroups.DeleteOnSubmit(hole);
            db.SubmitChanges();
        }


        public void Add(Hole hole)
        {
            db.Holes.InsertOnSubmit(hole);
        }

        public void Add(HoleUA hole)
        {
            db.HoleUAs.InsertOnSubmit(hole);
        }

        public void Add(LB3.Models.Group group)
        {
            db.Groups.InsertOnSubmit(group);
        }

        public void Add(UserGroup ug)
        {
            db.UserGroups.InsertOnSubmit(ug);
        }

        public void Add(Score sc)
        {
            db.Scores.InsertOnSubmit(sc);
        }

        public int Add(CourseUA c)
        {
            db.CourseUAs.InsertOnSubmit(c);
            db.SubmitChanges();
            return c.ID;
        }

        public int Add(Year y)
        {
            db.Years.InsertOnSubmit(y);
            db.SubmitChanges();
            return y.YID;
        }

        public void Add(Event e)
        {
            db.Events.InsertOnSubmit(e);
        }

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
