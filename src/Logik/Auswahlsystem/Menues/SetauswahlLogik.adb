with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;

with MausauswahlLogik;
with TasteneingabeLogik;
with OftVerwendeterSound;

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
        ZehnerReihe * 10 < ArraysHTSEB.SetsEinlesen'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        ArraysHTSEB.SetsEinlesen (ZehnerReihe * 10 - 9) = TextKonstantenHTSEB.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      Auswahlmöglichkeiten := (others => TextKonstantenHTSEB.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > ArraysHTSEB.SetsEinlesen'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = ArraysHTSEB.SetsEinlesen'First
           and
             ArraysHTSEB.SetsEinlesen (EndeSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
         then
            MeldungssystemHTSEB.Logik (MeldungExtern => "SetauswahlLogik.SetlisteFestlegen: Keine Einträge vorhanden");
            
         elsif
           EndeSchleifenwert > ArraysHTSEB.SetsEinlesen'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           ArraysHTSEB.SetsEinlesen (EndeSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         Auswahlmöglichkeiten (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := ArraysHTSEB.SetsEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrEinträgeVorhandenSchleife:
      for EinträgeSchleifenwert in ArraysHTSEB.SetsEinlesen'Range loop
         
         if
           EinträgeSchleifenwert <= ArraysHTSEB.SetsArray'Last
           and
             ArraysHTSEB.SetsEinlesen (EinträgeSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
         then
            SchreibeGrafiktask.Endauswahl (AuswahlExtern => Ende);
            SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => MehrereSeiten);
            return;
            
         elsif
           EinträgeSchleifenwert >= ArraysHTSEB.SetsArray'Last
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
                  OftVerwendeterSound.Klick;
                  SetlisteFestlegen;
                  
               else
                  OftVerwendeterSound.Klick;
                  return Auswahlmöglichkeiten (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return TextKonstantenHTSEB.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSet;

end SetauswahlLogik;
