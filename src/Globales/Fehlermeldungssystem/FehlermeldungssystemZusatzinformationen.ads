with KartenRecords;

package FehlermeldungssystemZusatzinformationen is
   pragma Pure;

   function Koordinaten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Wide_Wide_String
     with
       Post => (
                  Koordinaten'Result'Length > 0
               );

end FehlermeldungssystemZusatzinformationen;
