pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeStadtGebaut;

with TexteingabeLogik;

package body StadtAllgemeinLogik is

   procedure NeuerStadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NeuerName := TexteingabeLogik.StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
      if
        NeuerName.ErfolgreichAbbruch = True
      then
         SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                   NameExtern             => NeuerName.EingegebenerText);
                  
      else
         null;
      end if;
        
   end NeuerStadtname;

end StadtAllgemeinLogik;
