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

        public void UpdateScore(int ScoreID, int score)
        {
            var sc = db.Scores
                .Where(s => s.ScID == ScoreID)
                .First();

            sc.Score1 = score;
            db.SubmitChanges();

            InitTimer(ScoreID,0,0,0,0);

        }

        public void InitTimer(int ScoreID, int GID, int YID, int HID, int UserID)
        {
            myTimer.AutoReset = false;
            
         myTimer.Elapsed += delegate { CheckScore(ScoreID,GID,YID,HID,UserID); };
            myTimer.Interval = 8000;
            myTimer.Start();

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

                var courseID = hole.First().CourseID;

                var holeNum = hole.First().HoleNum;

                var course = from c in db.Courses
                             where c.CID == courseID
                             select c;

                myTimer.Stop();

                if (score_ct == 4)
                {
                    Event e = new Event();
                    e.Timestamp = DateTime.Now;
                    e.Name = course.First().CourseName + ", hole " + holeNum;
                    e.Comment = "Hole complete";

                    

                    Add(e);
                    Save();
                }
                                

            } else {
                    var score = from s in db.Scores
                                 where s.ScID == ScoreID
                                 select s;

                   

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

                    var courseID = hole.First().CourseID;

                    var holeNum = hole.First().HoleNum;

                    var course = from c in db.Courses
                                 where c.CID == courseID
                                 select c;

                    myTimer.Stop();

                    if (score_ct == 4)
                    {
                        Event e = new Event();
                        e.Timestamp = DateTime.Now;
                        e.Name = course.First().CourseName + ", hole " + holeNum;
                        e.Comment = "Hole modified and complete";


                        Add(e);
                        Save();

                    }

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

            sc.PinUserID = LDuserid;
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


        public void Add(Hole hole)
        {
            db.Holes.InsertOnSubmit(hole);
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
