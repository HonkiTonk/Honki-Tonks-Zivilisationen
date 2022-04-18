pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      TextHintergrund (WelchesMenüExtern     => WelchesMenüExtern,
                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Textbearbeitung (WelchesMenüExtern => WelchesMenüExtern);
      
      -- Hier braucht es keine Schleife, weil nur ein Text angezeigt werden soll.
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (WelchesMenüExtern, AktuelleAuswahlExtern));
      
   end AuswahlMenüsZusatztext;
   
   
   
   procedure TextHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      if
        AktuelleAuswahlExtern mod 2 = 0
      then
         null;
         
      else
         null;
      end if;
      
      case
        WelchesMenüExtern
      is
         when others =>
            null;
      end case;
      
   end TextHintergrund;
   
   
   
   procedure Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum)
   is begin
      
      AktuelleAuflösung := GrafikEinstellungenSFML.AktuelleFensterAuflösung;
      AktuelleSchriftgröße := GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße;
      -------------------- Hier gibt es nur eine Farbe, aber diese soll später vom Nutzer anpassbar sein.
      -- AktuelleSchriftfarben := GrafikEinstellungenSFML.Schriftfarben;

      case
        SchriftartFestgelegt (WelchesMenüExtern)
      is
         when False =>
            FontSchleife:
            for FontSchleifenwert in TextAccessArray'Range (2) loop
            
               Sf.Graphics.Text.setFont (text => TextAccess (WelchesMenüExtern, FontSchleifenwert),
                                         font => GrafikEinstellungenSFML.SchriftartAccess);
            
            end loop FontSchleife;
            
            SchriftartFestgelegt (WelchesMenüExtern) := True;
            
         when True =>
            null;
      end case;
      
      
      
   end Textbearbeitung;
   
   
   
   procedure SchriftartZurücksetzen
   is begin
      
      SchriftartFestgelegt := (others => LeerSchriftartFestgelegt);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
      AuswahlMenuesZusatztextSFML.SchriftartZurücksetzen;
      
   end SchriftartZurücksetzen;
   
   
   
   procedure TextZurücksetzen
   is begin
      
      TextFestgelegt := (others => False);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
      AuswahlMenuesZusatztextSFML.TextZurücksetzen;
      
   end TextZurücksetzen;
   
   
   
   procedure SchriftgrößeZurücksetzen
   is begin
      
      SchriftgrößeFestgelegt := (others => LeerSchriftgrößeFestgelegt);
      AuflösungBerechnet := (others => LeerAuflösungBerechnet);
      
      AuswahlMenuesZusatztextSFML.SchriftgrößeZurücksetzen;
      
   end SchriftgrößeZurücksetzen;

end AuswahlMenuesZusatztextSFML;
