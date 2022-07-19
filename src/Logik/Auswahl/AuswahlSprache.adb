pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with TextKonstanten;
with GrafikDatentypen;
with OptionenVariablen;

with Eingabe;
with GrafikEinstellungenSFML;
with Fehler;
with NachGrafiktask;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      ZeilenAbstand := 0.15 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
            
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return AuswahlSpracheTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return AuswahlSpracheSFML;
      end case;
      
   end AuswahlSprache;
   
   
   
   procedure SprachenListeFestlegen
   is begin
      
      AktuelleAuswahl := AktuelleSprachenArray'First;
      
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
      
   end SprachenListeFestlegen;
   
   
   
   function AuswahlSpracheTerminal
     return Unbounded_Wide_Wide_String
   is begin
                  
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
      
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
      
      case
        SchriftartFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setFont (text => TextAccess,
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            SchriftartFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                               size => GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
            SchriftgrößeFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Sprache_Enum;
      
      AuswahlSchleife:
      loop
            
         MausAuswahl;
            
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
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return TextKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlSpracheSFML;
   
   
   
   procedure MausAuswahl
   is begin
      
      TextPositionMaus := StartPositionYAchse;
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      MausZeigerSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                            str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
         
         if
           AktuelleSprachen (ZeileSchleifenwert) = MehrSprachen
         then
            TextPositionMaus := TextPositionMaus + 15.00;
            
         else
            null;
         end if;
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (TextPositionMaus)
           .. Sf.sfInt32 (TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height)
         then
            AktuelleAuswahl := ZeileSchleifenwert;
            return;
         
         else
            TextPositionMaus := TextPositionMaus + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height + 3.00 * ZeilenAbstand;
         end if;
         
      end loop MausZeigerSchleife;
      
   end MausAuswahl;
   
end AuswahlSprache;
