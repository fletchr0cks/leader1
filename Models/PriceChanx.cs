//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace dt1.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PriceChanx
    {
        public int Id { get; set; }
        public string Coin { get; set; }
        public Nullable<System.DateTime> Time_start { get; set; }
        public Nullable<System.DateTime> Time_end { get; set; }
        public Nullable<decimal> Up { get; set; }
        public Nullable<decimal> Down { get; set; }
        public Nullable<int> Duration { get; set; }
        public string UniqueID { get; set; }
        public Nullable<decimal> profit { get; set; }
    }
}
