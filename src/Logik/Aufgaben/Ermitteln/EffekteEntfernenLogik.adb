with EinheitenDatentypen;

package body EffekteEntfernenLogik is

   function EffekteEntfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        KoordinatenExtern.YAchse = 1
        or
          EinheitSpeziesNummerExtern.Nummer = 1
          or
            AnlegenTestenExtern
      then
         null;
         
      else
         null;
      end if;
      
      return False;
      
   end EffekteEntfernen;

end EffekteEntfernenLogik;
