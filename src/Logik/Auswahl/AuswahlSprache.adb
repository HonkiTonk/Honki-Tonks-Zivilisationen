pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;

with GlobaleTexte;
with TextKonstanten;
with GrafikDatentypen;
with OptionenVariablen;
with InteraktionAuswahl;
with SystemKonstanten;

with Eingabe;
with Fehler;
with NachGrafiktask;
with NachLogiktask;
with Vergleiche;
with Views;
with GrafikEinstellungenSFML;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
            
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return AuswahlSpracheTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return AuswahlSpracheSFML;
      end case;
      
   end AuswahlSprache;
   
   
   
   -- Kann diese Prozedur nicht in den Grafiktask verschoben werden? Irgendwie. äöü
   procedure SprachenListeFestlegen
   is begin
            
      if
        ZehnerReihe * 10 < GlobaleTexte.SprachenEinlesenArray'Last
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
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = GlobaleTexte.SprachenEinlesenArray'First
           and
             GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Fehler.LogikFehler (FehlermeldungExtern => "AuswahlSprache.SprachenListeFestlegen - Keine Sprachen vorhanden.");
            
         elsif
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
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
      for SprachenSchleifenwert in GlobaleTexte.SprachenEinlesenArray'Range loop
         
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
      AktuelleSprachen (Ende) := MehrSprachen;
      MehrereSeiten := True;
      
      NachGrafiktask.Endauswahl := Ende;
      NachGrafiktask.MehrereSeiten := MehrereSeiten;
      
   end SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheTerminal
     return Unbounded_Wide_Wide_String
   is begin
      
      AktuelleAuswahl := AktuelleSprachenArray'First;
            
      AuswahlTerminalSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum | TastenbelegungDatentypen.Ebene_Hoch_Enum =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum | TastenbelegungDatentypen.Ebene_Runter_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
               then
                  SprachenListeFestlegen;
                  
               else
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
                     
            when others =>
               null;
         end case;
               
      end loop AuswahlTerminalSchleife;
      
   end AuswahlSpracheTerminal;
   
   
   
   function AuswahlSpracheSFML
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlSchleife:
      loop
            
         AktuelleAuswahl := MausAuswahl;
         NachGrafiktask.AktuelleAuswahl := AktuelleAuswahl;
            
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               elsif
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
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
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
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
