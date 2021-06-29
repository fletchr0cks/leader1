using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using dt1.Models;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using System.Globalization;


namespace dt1.Controllers
{
    public class HomeController : Controller
    {

        public class Area
        {
           // public int AreaId { get; set; }

          
            public string Title { get; set; }
           // public bool Archive { get; set; }

          
        }

        public ActionResult Index()
        {
            var dataContext = new db61a6afb29dc84f4597e3a2b500ebed20Entities();

            var data = from y in dataContext.PriceDatas
                       orderby y.Timestamp descending
                       select y;

            return View("Index", data);
        }
        public static DateTime? ConvertUnixTimeStamp(string unixTimeStamp)
        {
            return new DateTime(1970, 1, 1).AddSeconds(Convert.ToDouble(unixTimeStamp));
        }

        public JsonResult saveChangeData(string time_start, string time_end, decimal up, decimal down,int duration, string coin, decimal profit)
        {
            DateTime start_epoch = new DateTime(1970, 1, 1).AddSeconds(Convert.ToDouble(time_start)/1000);
            DateTime end_epoch = new DateTime(1970, 1, 1).AddSeconds(Convert.ToDouble(time_end) / 1000);
            string uniqueID = coin + time_start + time_end + up.ToString() + down.ToString() + duration.ToString();
            string status;
            var dataContext = new db61a6afb29dc84f4597e3a2b500ebed20Entities();

            var data = from y in dataContext.PriceChanges
                       where y.UniqueID == uniqueID
                       select y;

        
            int ct = data.Count();

            if (ct == 0)
            {

                using (var context = new db61a6afb29dc84f4597e3a2b500ebed20Entities())
                {
                    var t = new PriceChanx
                    {
                        Coin = coin,
                        Time_start = start_epoch,
                        Time_end = end_epoch,
                        Up = up,
                        Down = down,
                        Duration = duration,
                        UniqueID = uniqueID,
                        profit = profit

                    };

                    context.PriceChanges.Add(t);

                    context.SaveChanges();

                    status = "Saved: " + duration;
                }

            } else
            {
                status = "Not saved: " + duration;
            }


            return Json(new { status = status }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult saveData(string price_data, int count, string coin)
        {
           
            dynamic stuff = JsonConvert.DeserializeObject(price_data);
            
            
            string[] Users = stuff[0].ToObject<string[]>();

           // int ac = 0;
            do
            {
               // string subArray = stuff[1];
                string[] SubArrayData = stuff[count].ToObject<string[]>();
                string price = SubArrayData[1];
                decimal price2 = Convert.ToDecimal(price);
                string date1 = SubArrayData[0];
                double epoch = Convert.ToDouble(date1);
                DateTime datex = new DateTime(1970, 1, 1).AddSeconds(epoch/1000);
                //DateTime date4 = ConvertUnixTimeStamp(date1);


                // string date2 = Regex.Replace(date1, @"[^\d\s\.:]", string.Empty);
                // DateTime date3 = DateTime.ParseExact(date1, "MM.dd.yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                //DateTime time = DateTime.ParseExact(SubArrayData[0], "dd/MM/yyyy", null);

                // string data1 = subArray[0];
                //Decimal price = stuff[ac].price;
                //DateTime time = stuff[ac].price_timestamp;
                //decimal? rank = stuff[ac].rank;
                //decimal? rankdelta = stuff[ac].rank_delta;
                //decimal marketcap = stuff[ac].market_cap;
                //string symbol = stuff[ac].symbol;
                //textBox1.AppendText(coinname + Environment.NewLine);
                //textBox1.AppendText(price + Environment.NewLine);
                //textBox1.AppendText(time + Environment.NewLine);
                using (var context = new db61a6afb29dc84f4597e3a2b500ebed20Entities())
                {
                    var t = new PriceData
                    {
                        Coin = coin,
                        Price = price2,
                        //Rank = rank,
                        //Rankdelta = rankdelta,
                        //Marketcap = marketcap,
                        //Symbol = symbol,
                        Timestamp = datex
                    };

                    context.PriceDatas.Add(t);

                    context.SaveChanges();
                }

                count--;
            } while (count > 0);



            return Json(new { status = "saved" }, JsonRequestBehavior.AllowGet);

        }
        public JsonResult PData(string coin, int days, DateTime from_dt, DateTime to_dt)
        {
            var dataContext = new db61a6afb29dc84f4597e3a2b500ebed20Entities();
            var dt = DateTime.Now.AddDays(-days);
            //from_dt = Convert.ToDateTime("10/02/2021");

            // var coinList;
             List<Area> coinList = new List<Area>();

           // IList<PriceData> cl = new IList<PriceData>;

            var data = (from y in dataContext.PriceDatas
                        where y.Timestamp > from_dt
                        where y.Timestamp < to_dt
                        where y.Coin == coin
                        orderby y.Timestamp ascending
                        select new
                        {
                           
                            y.Price,
                            y.Timestamp,
                            y.MA100,
                            y.MA50

                        });

            //dataContext.PriceChanges
            //            .Where(c => c.Coin == coin).Average(r => r.Down);


            return Json(new { data_out = data }, JsonRequestBehavior.AllowGet);
            //graph needs, [[time,price],[time,price]]
        }


        public JsonResult PLata(int days)
        {
            var dataContext = new db61a6afb29dc84f4597e3a2b500ebed20Entities();

            var dt = DateTime.Now.AddDays(-days);


            var data = (from y in dataContext.Orders
                        where y.Timestamp > dt                    
                        orderby y.Timestamp descending
                        select new
                        {
                            y.Price,
                            y.Timestamp,
                            y.PLpct
                        });

            //dataContext.PriceChanges
            //            .Where(c => c.Coin == coin).Average(r => r.Down);


            return Json(new { data_out = data }, JsonRequestBehavior.AllowGet);
            //graph needs, [[time,price],[time,price]]
        }




        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}