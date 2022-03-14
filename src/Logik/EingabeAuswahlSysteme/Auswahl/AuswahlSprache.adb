pragma SPARK_Mode (On);

with GlobaleVariablen;
with GlobaleTexte;
with SystemKonstanten;
with SystemDatentypen;
with TastenbelegungKonstanten;

with Eingabe;
with GrafikEinstellungenSFML;
with Fehler;
with InteraktionGrafiktask;

package body AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
   is begin
      
      ZehnerReihe := 0;
      ZeilenAbstand := 0.15 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      MehrereSeiten := False;
      
      SprachenListeFestlegen;
            
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return AuswahlSpracheKonsole;
            
         when SystemDatentypen.Grafik_SFML =>
            return AuswahlMausTastatur;
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
        GlobaleTexte.SprachenEinlesen (ZehnerReihe * 10 - 9) = SystemKonstanten.LeerUnboundedString
      then
         ZehnerReihe := 1;
         
      else
         null;
      end if;
      
      AktuelleSprachen := (others => SystemKonstanten.LeerUnboundedString);
      
      EndeBestimmenSchleife:
      for EndeSchleifenwert in ZehnerReihe * 10 - 9 .. ZehnerReihe * 10 loop
         
         if
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
            
         elsif
           EndeSchleifenwert = GlobaleTexte.SprachenEinlesenArray'First
           and
             GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = SystemKonstanten.LeerUnboundedString
         then
            Fehler.LogikFehler (FehlermeldungExtern => "AuswahlSprache.SprachenListeFestlegen - Keine Sprachen vorhanden.");
            
         elsif
           EndeSchleifenwert > GlobaleTexte.SprachenEinlesenArray'Last
         then
            exit EndeBestimmenSchleife;
           
         elsif
           GlobaleTexte.SprachenEinlesen (EndeSchleifenwert) = SystemKonstanten.LeerUnboundedString
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
             GlobaleTexte.SprachenEinlesen (SprachenSchleifenwert) = SystemKonstanten.LeerUnboundedString
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
   
   
   
   function AuswahlSpracheKonsole
     return Unbounded_Wide_Wide_String
   is begin
      
      AuswahlKonsoleSchleife:
      loop
                  
         InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Sprache);
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungKonstanten.ObenKonstante | TastenbelegungKonstanten.EbeneHochKonstante =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungKonstanten.UntenKonstante | TastenbelegungKonstanten.EbeneRunterKonstante =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungKonstanten.AuswählenKonstante =>
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
               
      end loop AuswahlKonsoleSchleife;
      
   end AuswahlSpracheKonsole;
   
   
   
   function AuswahlMausTastatur
     return Unbounded_Wide_Wide_String
   is begin
            
      Sf.Graphics.Text.setFont (text => TextAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      Sf.Graphics.Text.setCharacterSize (text => TextAccess,
                                         size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Sprache);
      
      AuswahlSchleife:
      loop
            
         MausAuswahl;
            
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungKonstanten.ObenKonstante | TastenbelegungKonstanten.EbeneHochKonstante =>
               if
                 AktuelleAuswahl = AktuelleSprachen'First
               then
                  AktuelleAuswahl := Ende;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungKonstanten.UntenKonstante | TastenbelegungKonstanten.EbeneRunterKonstante =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := AktuelleSprachen'First;
                  
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when TastenbelegungKonstanten.AuswählenKonstante =>
               if
                 AktuelleSprachen (AktuelleAuswahl) = MehrSprachen
               then
                  SprachenListeFestlegen;
                  
               else
                  return AktuelleSprachen (AktuelleAuswahl);
               end if;
               
            when TastenbelegungKonstanten.MenüZurückKonstante =>
               return SystemKonstanten.LeerUnboundedString;
            
            when others =>
               null;
         end case;
      
      end loop AuswahlSchleife;
      
   end AuswahlMausTastatur;
   
   
   
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
