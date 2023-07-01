with Ada.Calendar; use Ada.Calendar;

with SchreibeGrafiktask;

package body MeldungFestlegenLogik is

   procedure MeldungFestlegen
     (MeldungExtern : in Positive)
   is begin
      
      -- Hier sollte immer erst die Zeit festgelegt werden, da die Grafik ja die Meldung auf 0 setzen kann.
      SchreibeGrafiktask.Spielmeldungszeit (ZeitExtern => Clock);
      SchreibeGrafiktask.Spielmeldung (MeldungExtern => MeldungExtern);
      
   end MeldungFestlegen;
   
   
   
   procedure SpielermeldungFestlegen
     (MeldungExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            MeldungFestlegen (MeldungExtern => MeldungExtern);
            
         when others =>
            null;
      end case;
      
   end SpielermeldungFestlegen;

end MeldungFestlegenLogik;
