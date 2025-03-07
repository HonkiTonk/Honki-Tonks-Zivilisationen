with MeldungssystemHTSEB;

with GrafikDatentypen;
with TextKonstanten;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;

with MausauswahlLogik;
with TasteneingabeLogik;
with OftVerwendetSound;

package body SetauswahlLogik is

   function Setauswahl
     (SpracheExtern : in Boolean)
      return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      SetlisteFestlegen;
      
      case
        SpracheExtern
      is
         when True =>
            SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Sprache_Enum);
            
         when False =>
            SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Set_Enum);
      end case;
            
      return AuswahlSet;
      
   end Setauswahl;
   
   
   
   procedure SetlisteFestlegen
   is begin
            
      if
        ZehnerReihe * 10 < TextArrays.SetsEinlesen'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        TextArrays.SetsEinlesen (ZehnerReihe * 10 - 9) = TextKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      Auswahlmöglichkeiten := (others => TextKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > TextArrays.SetsEinlesen'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = TextArrays.SetsEinlesen'First
           and
             TextArrays.SetsEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            MeldungssystemHTSEB.Logik (MeldungExtern => "SetauswahlLogik.SetlisteFestlegen: Keine Einträge vorhanden");
            
         elsif
           EndeSchleifenwert > TextArrays.SetsEinlesen'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           TextArrays.SetsEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         Auswahlmöglichkeiten (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := TextArrays.SetsEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrEinträgeVorhandenSchleife:
      for EinträgeSchleifenwert in TextArrays.SetsEinlesen'Range loop
         
         if
           EinträgeSchleifenwert <= TextArrays.SetsArray'Last
           and
             TextArrays.SetsEinlesen (EinträgeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            SchreibeGrafiktask.Endauswahl (AuswahlExtern => Ende);
            SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => MehrereSeiten);
            return;
            
         elsif
           EinträgeSchleifenwert >= TextArrays.SetsArray'Last
         then
            exit MehrEinträgeVorhandenSchleife;
            
         else
            null;
         end if;
            
      end loop MehrEinträgeVorhandenSchleife;
      
      Ende := Ende + 1;
      MehrereSeiten := True;
      
      SchreibeGrafiktask.Endauswahl (AuswahlExtern => Ende);
      SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => MehrereSeiten);
      
   end SetlisteFestlegen;
   
   
   
   function AuswahlSet
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlSchleife:
      loop
            
         AktuelleAuswahl := MausauswahlLogik.Setauswahl (AnfangExtern => Auswahlmöglichkeiten'First,
                                                         EndeExtern   => Ende);
         SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AktuelleAuswahl);
            
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleAuswahl = Ende
                 and
                   MehrereSeiten
               then
                  OftVerwendetSound.Klick;
                  SetlisteFestlegen;
                  
               else
                  OftVerwendetSound.Klick;
                  return Auswahlmöglichkeiten (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSet;

end SetauswahlLogik;
