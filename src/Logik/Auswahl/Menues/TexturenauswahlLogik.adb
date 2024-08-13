with TextKonstanten;
with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeGrafiktask;

with TasteneingabeLogik;
with Fehlermeldungssystem;
with MausauswahlLogik;
with OftVerwendetSound;

package body TexturenauswahlLogik is

   function AuswahlTexturen
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      TexturenlisteFestlegen;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Texturen_Enum);
      
      return AuswahlTexturenSFML;
      
   end AuswahlTexturen;
   
   
   
   procedure TexturenlisteFestlegen
   is begin
            
      if
        ZehnerReihe * 10 < TextArrays.SprachenTexturenEinlesen'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        TextArrays.SprachenTexturenEinlesen (ZehnerReihe * 10 - 9) = TextKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      AktuelleTexturen := (others => TextKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > TextArrays.SprachenTexturenEinlesen'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = TextArrays.SprachenTexturenEinlesen'First
           and
             TextArrays.SprachenTexturenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "TexturenauswahlLogik.TexturenlisteFestlegen: Keine Texturen vorhanden");
            
         elsif
           EndeSchleifenwert > TextArrays.SprachenTexturenEinlesen'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           TextArrays.SprachenTexturenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         AktuelleTexturen (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := TextArrays.SprachenTexturenEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrSprachenVorhandenSchleife:
      for SprachenSchleifenwert in TextArrays.SprachenTexturenEinlesen'Range loop
         
         if
           SprachenSchleifenwert <= TextArrays.SprachenArray'Last
           and
             TextArrays.SprachenTexturenEinlesen (SprachenSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            SchreibeGrafiktask.Endauswahl (AuswahlExtern => Ende);
            SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => MehrereSeiten);
            return;
            
         elsif
           SprachenSchleifenwert >= TextArrays.SprachenArray'Last
         then
            exit MehrSprachenVorhandenSchleife;
            
         else
            null;
         end if;
            
      end loop MehrSprachenVorhandenSchleife;
      
      Ende := Ende + 1;
      MehrereSeiten := True;
      
      SchreibeGrafiktask.Endauswahl (AuswahlExtern => Ende);
      SchreibeGrafiktask.Seitenauswahl (JaNeinExtern => MehrereSeiten);
      
   end TexturenlisteFestlegen;
   
   
   
   function AuswahlTexturenSFML
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlSchleife:
      loop
            
         AktuelleAuswahl := MausauswahlLogik.Sprachenauswahl (AnfangExtern => AktuelleTexturen'First,
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
                  TexturenlisteFestlegen;
                  
               else
                  OftVerwendetSound.Klick;
                  return AktuelleTexturen (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlTexturenSFML;

end TexturenauswahlLogik;
