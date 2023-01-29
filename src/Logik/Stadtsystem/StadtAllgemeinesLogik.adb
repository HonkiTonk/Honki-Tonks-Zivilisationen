with SchreibeStadtGebaut;

with TexteingabeLogik;

package body StadtAllgemeinesLogik is

   procedure NeuerStadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      NeuerName := TexteingabeLogik.StadtName (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               BauenExtern              => False);
               
      case
        NeuerName.ErfolgreichAbbruch
      is
         when True =>
            SchreibeStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      NameExtern               => NeuerName.EingegebenerText);
            
         when False =>
            null;
      end case;
        
   end NeuerStadtname;

end StadtAllgemeinesLogik;
