pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;

with GlobaleTexte;
with TextKonstanten;
with GrafikDatentypen;
with InteraktionAuswahl;
with SystemKonstanten;
with TastenbelegungDatentypen;

with TasteneingabeLogik;
with Fehler;
with NachGrafiktask;
with NachLogiktask;
with Vergleiche;
with Views;
with EinstellungenGrafik;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
            
      return AuswahlSpracheSFML;
      
   end AuswahlSprache;
   
   
   
   -- Kann diese Prozedur nicht in den Grafiktask verschoben werden? Irgendwie. äöü
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
            Fehler.LogikFehler (FehlermeldungExtern => "AuswahlSprache.SprachenListeFestlegen - Keine Sprachen vorhanden.");
            
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
            
         AktuelleAuswahl := MausAuswahl;
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
            
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleAuswahl = Ende
                 and
                   MehrereSeiten
               then
                  SprachenListeFestlegen;
                  
               else
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSpracheSFML;
   
   
   
   function MausAuswahl
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      MausZeigerSchleife:
      for PositionSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSprachauswahl (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;
   
end AuswahlSprache;
