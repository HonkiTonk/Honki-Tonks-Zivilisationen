with GlobaleTexte;
with TextKonstanten;
with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with TasteneingabeLogik;
with Fehlermeldungssystem;
with NachGrafiktask;
with MausauswahlLogik;
with OftVerwendetSound;

package body SprachauswahlLogik is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
            
      return AuswahlSpracheSFML;
      
   end AuswahlSprache;
   
   
   
   procedure SprachenListeFestlegen
   is begin
            
      if
        ZehnerReihe * 10 < GlobaleTexte.SprachenEinlesen'Last
      then
         ZehnerReihe := ZehnerReihe + 1;
         
      else
         ZehnerReihe := 1;
      end if;
         
      if
        GlobaleTexte.SprachenEinlesen (ZehnerReihe * 10 - 9) = TextKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      AktuelleSprachen := (others => TextKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesen'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = GlobaleTexte.SprachenEinlesen'First
           and
             GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SprachauswahlLogik.SprachenListeFestlegen: Keine Sprachen vorhanden");
            
         elsif
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesen'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit EndeBestimmenSchleife;
            
         else
            Ende := EndeSchleifenwert - ((ZehnerReihe - 1) * 10);
         end if;
         
         AktuelleSprachen (EndeSchleifenwert - ((ZehnerReihe - 1) * 10)) := GlobaleTexte.SprachenEinlesen (EndeSchleifenwert);
         
      end loop EndeBestimmenSchleife;
      
      MehrSprachenVorhandenSchleife:
      for SprachenSchleifenwert in GlobaleTexte.SprachenEinlesen'Range loop
         
         if
           SprachenSchleifenwert <= AktuelleSprachenArray'Last
           and
             GlobaleTexte.SprachenEinlesen (SprachenSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            NachGrafiktask.Endauswahl := Ende;
            NachGrafiktask.MehrereSeiten := MehrereSeiten;
            return;
            
         elsif
           SprachenSchleifenwert >= AktuelleSprachenArray'Last
         then
            exit MehrSprachenVorhandenSchleife;
            
         else
            null;
         end if;
            
      end loop MehrSprachenVorhandenSchleife;
      
      Ende := Ende + 1;
      MehrereSeiten := True;
      
      NachGrafiktask.Endauswahl := Ende;
      NachGrafiktask.MehrereSeiten := MehrereSeiten;
      
   end SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheSFML
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlSchleife:
      loop
            
         AktuelleAuswahl := MausauswahlLogik.Sprachenauswahl (AnfangExtern => AktuelleSprachen'First,
                                                              EndeExtern   => Ende);
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
            
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
                  SprachenListeFestlegen;
                  
               else
                  OftVerwendetSound.Klick;
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSpracheSFML;
         
end SprachauswahlLogik;
