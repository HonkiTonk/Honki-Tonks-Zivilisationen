with KartenartDatentypen; use KartenartDatentypen;
with KartenDatentypen; use KartenDatentypen;
with Weltkarte;

package body KIEAchsenbewertung is

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        AktuelleEbeneExtern /= ZielebeneExtern
        and
          NeueEbeneExtern = ZielebeneExtern
      then
         return 10;
      
      elsif
        AktuelleEbeneExtern = ZielebeneExtern
        and
          NeueEbeneExtern = ZielebeneExtern
      then
         return 10;
         
      elsif
        AktuelleEbeneExtern = NeueEbeneExtern
      then
         return 5;
         
      else
         EntfernungZiel := 0;
         EntfernungAlt := 0;
         EntfernungNeu := 0;
      end if;
      
      if
        Weltkarte.Karteneinstellungen.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
      then
         TestSchleife:
         for TestSchleifenwert in KartenDatentypen.EbeneVorhanden'Range loop
            
            if
              TestSchleifenwert >= ZielebeneExtern
            then
               EntfernungZiel := EntfernungZiel + 1;
               
            else
               null;
            end if;
            
            if
              TestSchleifenwert >= AktuelleEbeneExtern
            then
               EntfernungAlt := EntfernungAlt + 1;
               
            else
               null;
            end if;
            
            if
              TestSchleifenwert >= NeueEbeneExtern
            then
               EntfernungNeu := EntfernungNeu + 1;
               
            else
               null;
            end if;
            
         end loop TestSchleife;
         
         if
         abs (EntfernungNeu - EntfernungZiel) < abs (EntfernungAlt - EntfernungZiel)
         then
            return 7;
            
         else
            return 3;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.EAchseOben = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
      then
         null;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.EAchseUnten = KartenartDatentypen.Karte_E_Kein_Übergang_Enum
      then
         null;
         
      else
         null;
      end if;
      
      return 0;
   
   end EAchseBewerten;

end KIEAchsenbewertung;
