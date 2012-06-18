using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using LB3.Models;
using System.IO;

namespace LB3.Models
{
    public class DataRepository
    {
        private lb3dataDataContext db = new lb3dataDataContext();

        public void UpdateScore(int ScoreID, int score)
        {
            var sc = db.Scores
                .Where(s => s.ScID == ScoreID)
                .First();

            sc.Score1 = score;
            db.SubmitChanges();
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

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
