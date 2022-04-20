pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (AktuelleAuswahlExtern : in Positive)
   is begin
            
      if
        AktuelleAuswahlExtern mod 2 = 0
      then
         LinksRechts := True;
         
      else
         LinksRechts := False;
      end if;
      
      TextHintergrund (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Textbearbeitung (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      -- Hier braucht es keine Schleife, weil nur ein Text angezeigt werden soll.
      -- Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
      --                                   text         => TextAccess (WelchesMenüExtern, AktuelleAuswahlExtern));
      
   end AuswahlMenüsZusatztext;
   
   
   
   procedure TextHintergrund
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      if
        AktuelleAuswahlExtern mod 2 = 0
      then
         null;
         
      else
         null;
      end if;
            
   end TextHintergrund;
   
   
   
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      AktuelleSchriftgröße := GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße;
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern - 1);
      -------------------- Hier gibt es nur eine Farbe, aber diese soll später vom Nutzer anpassbar sein.
      -- AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;

      case
        SchriftartFestgelegt
      is
         when False =>
            FontSchleife:
            for FontSchleifenwert in TextAccessArray'Range (2) loop
            
               Sf.Graphics.Text.setFont (text => TextAccess (RasseAnzeigen, FontSchleifenwert),
                                         font => GrafikEinstellungenSFML.SchriftartAccess);
            
            end loop FontSchleife;
            
            SchriftartFestgelegt := True;
            
         when True =>
            null;
      end case;
      
      case
        TextFestgelegt (RasseAnzeigen, AktuelleAuswahlExtern)
      is
         when False =>
            TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
            TextFestgelegt (RasseAnzeigen, AktuelleAuswahlExtern) := True;
            
         when True =>
            null;
      end case;
      
   end Textbearbeitung;
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      null;
      
   end TextFestlegen;
   
   
   
   procedure SchriftartZurücksetzen
   is begin
      
      SchriftartFestgelegt := False;
      AuflösungBerechnet := (others => (others => LeerAuflösungBerechnet));
      
      AuswahlMenuesZusatztextSFML.SchriftartZurücksetzen;
      
   end SchriftartZurücksetzen;
   
   
   
   procedure TextZurücksetzen
   is begin
      
      TextFestgelegt := (others => (others => False));
      AuflösungBerechnet := (others => (others => LeerAuflösungBerechnet));
      
      AuswahlMenuesZusatztextSFML.TextZurücksetzen;
      
   end TextZurücksetzen;
   
   
   
   procedure SchriftgrößeZurücksetzen
   is begin
      
      SchriftgrößeFestgelegt := (others => (others => LeerSchriftgrößeFestgelegt));
      AuflösungBerechnet := (others => (others => LeerAuflösungBerechnet));
      
      AuswahlMenuesZusatztextSFML.SchriftgrößeZurücksetzen;
      
   end SchriftgrößeZurücksetzen;

end AuswahlMenuesZusatztextSFML;
