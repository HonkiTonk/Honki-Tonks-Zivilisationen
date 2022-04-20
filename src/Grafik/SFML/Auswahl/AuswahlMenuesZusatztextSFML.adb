pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive)
   is begin
            
      if
        AktuelleAuswahlExtern mod 2 = 0
      then
         LinksRechts := True;
         
      else
         LinksRechts := False;
      end if;
      
      Textbearbeitung (WelchesMenüExtern     => WelchesMenüExtern,
                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      -- Die Größe des Hintergrundes kann erst nach der Festlegung des Textes der auf diesem Hintergrund gezeichnet werden soll festgelegt werden.
      TextHintergrund (WelchesMenüExtern => WelchesMenüExtern);
      
      -- Hier braucht es keine Schleife, weil nur ein Text angezeigt werden soll.
      -- Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
      --                                   text         => TextAccess (WelchesMenüExtern, AktuelleAuswahlExtern));
      
   end AuswahlMenüsZusatztext;
   
   
   
   procedure TextHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum)
   is begin
            
      null;
            
   end TextHintergrund;
   
   
   
   procedure Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      AktuelleSchriftgröße := GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße;
      -- RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      -- AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;

      case
        SchriftartFestgelegt
      is
         when False =>
            FontSchleife:
            for FontSchleifenwert in TextAccessArray'Range (2) loop
            
               Sf.Graphics.Text.setFont (text => TextAccess (WelchesMenüExtern, FontSchleifenwert),
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
            TextFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                           AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
            TextFestgelegt (RasseAnzeigen, AktuelleAuswahlExtern) := True;
            
         when True =>
            null;
      end case;
      
   end Textbearbeitung;
   
   
   
   procedure TextFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive)
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
