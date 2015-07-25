using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LB3.Models
{
    public partial class UserGroup
    {
       
        private lb3dataDataContext db = new lb3dataDataContext();

        public IEnumerable<Hole> GetHolesForCourse(int CID, int YID, int HoleNum)
        {
            return from holes in db.Holes where holes.CourseID == CID where holes.HoleNum == HoleNum  select holes;
        }

        public IEnumerable<Hole> GetHolesForCoursess(int CID, int YID)
        {
            var dataContext = new lb3dataDataContext();

            var comment = from a in dataContext.Holes
                          where a.CourseID == CID
                          where a.YearID == YID
                          select a;



            return (comment);
        }
        public int getScore(int HoleID, int YID, int UserID)
        {
            var dataContext = new lb3dataDataContext();

            var comment = from a in dataContext.Scores
                          where a.HoleID == HoleID
                          where a.YearID == YID
                          where a.UserID == UserID
                          select a;

            var score = 0;
            try
            {
                //hole has a score
                score = Convert.ToInt32(comment.First().Score1);
            }
            catch
            {
                score = -1;

            }

            return score;
        }

        public int checkScore(int HoleID, int YID, int UserID)
        {
            var dataContext = new lb3dataDataContext();

            var comment = from a in dataContext.Scores
                          where a.HoleID == HoleID
                          where a.YearID == YID
                          where a.UserID == UserID
                          select a;

            var next = from a in dataContext.Scores
                          where a.HoleID == (HoleID - 1)
                          where a.YearID == YID
                          where a.UserID == UserID
                          select a;


            var score = 0;
            try
            {
                //hole has a score
                score = Convert.ToInt32(comment.First().Score1);
            }
            catch
            {

                try
                {
                    score = Convert.ToInt32(next.First().Score1);
                    if (score > 0)
                    {
                        score = 0;
                    }

                }
                catch
                {

                    score = -1;
                }
            }
            return score;
        }
    }
}
