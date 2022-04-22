pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with RassenDatentypen; use RassenDatentypen;
with TextKonstanten;
with MenueDatentypen;

with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with TexturenSetzenSkalierenSFML;
with AuswahlMenuesStringsSetzen;
with InteraktionAuswahl;

package body AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      TextHintergrund (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Textbearbeitung (AktuelleRasseExtern => RasseAnzeigen);
      
      AktuellerTextbereichEins := TextKonstanten.LeerUnboundedString;
      AktuellerTextbereichZwei := TextKonstanten.LeerUnboundedString;
      BreiteTextfeld := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * VerhältnisTextfeld.x;
      
      Multiplikator := 1.00;
                    
      TextbereichSchleife:
      for TextbereichSchleifenwert in 1 .. To_Wide_Wide_String (Source => RassenTexte (RasseAnzeigen))'Last loop
         
         AktuellerTextbereichEins := AktuellerTextbereichEins & To_Wide_Wide_String (Source => RassenTexte (RasseAnzeigen)) (TextbereichSchleifenwert);
         AktuellerTextbereichZwei := AktuellerTextbereichZwei & To_Wide_Wide_String (Source => RassenTexte (RasseAnzeigen)) (TextbereichSchleifenwert);
            
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (RasseAnzeigen),
                                            str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
         
         if
           Sf.Graphics.Text.getLocalBounds (text => TextAccess (RasseAnzeigen)).width >= Multiplikator * BreiteTextfeld
         then
            AktuellerTextbereichZwei := AktuellerTextbereichZwei & Ada.Characters.Wide_Wide_Latin_1.LF;
            Multiplikator := Multiplikator + 1.00;
            
         else
            null;
         end if;
            
      end loop TextbereichSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (RasseAnzeigen),
                                         str  => To_Wide_Wide_String (Source => AktuellerTextbereichZwei));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (RasseAnzeigen));
      
   end AnzeigeZusatztextRassenmenü;
   
   
   
   procedure TextHintergrund
     (AktuelleAuswahlExtern : in Positive)
   is begin
            
      if
        EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum) /= null
      then
         case
           AktuelleAuswahlExtern mod 2
         is
            when 0 =>
               PositionHintergrund := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 100.00, InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Rassen_Menü_Enum, 1).top);
               
            when others =>
               PositionHintergrund := ((Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) + Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 100.00) / 2.00,
                                       InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Rassen_Menü_Enum, 1).top);
         end case;
         
         Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
                                         position => PositionHintergrund);
         
         Sf.Graphics.Sprite.scale (sprite  => SpriteAccess,
                                   factors => TexturenSetzenSkalierenSFML.TexturenSetzenSkalierenTeilBild (SpriteAccessExtern  => SpriteAccess,
                                                                                                           TextureAccessExtern => EingeleseneTexturenSFML.MenüHintergrundAccess (MenueDatentypen.Rassen_Menü_Enum),
                                                                                                           VerhältnisExtern    => VerhältnisTextfeld));
         
         Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                              object       => SpriteAccess);
         
      else
         -------------------- Später hier einen einfarbigen Hintergrund wie bei den Kartenfeldern einbauen.
         null;
      end if;
      
   end TextHintergrund;
   
   
   
   procedure Textbearbeitung
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbeFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößeFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        TextFestgelegt
      is
         when False =>
            TextFestgelegt := TextFestlegen;
            
         when True =>
            null;
      end case;
      
      if
        AktuelleRasseExtern /= LetzteRasse
      then
         SchriftpositionFestlegen (AktuelleRasseExtern => AktuelleRasseExtern);
         LetzteRasse := AktuelleRasseExtern;
         
      else
         null;
      end if;
      
   end Textbearbeitung;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      FontSchleife:
      for FontSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (FontSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop FontSchleife;
            
      return True;
      
   end SchriftartFestlegen;
   
   
   
   function SchriftfarbeFestlegen
     return Boolean
   is begin
      
      FarbeSchleife:
      for FarbeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (FarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop FarbeSchleife;
      
      return True;
      
   end SchriftfarbeFestlegen;
   
   
   
   function SchriftgrößeFestlegen
     return Boolean
   is begin
      
      GrößeSchleife:
      for GrößeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (GrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop GrößeSchleife;
      
      return True;
      
   end SchriftgrößeFestlegen;
   
   
   
   function TextFestlegen
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         ----------------------- Hier direkt auf die GlobaleTexte zugreifen?
         RassenTexte (RasseSchleifenwert) :=
           To_Unbounded_Wide_Wide_String (Source => AuswahlMenuesStringsSetzen.AuswahlMenüZusatztextStringSetzen (WelcheZeileExtern => 2 * RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert),
                                                                                                                   WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum));
         
      end loop RassenSchleife;
      
      return True;
            
   end TextFestlegen;
   
   
   
   procedure SchriftpositionFestlegen
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (AktuelleRasseExtern),
                                    position => PositionHintergrund);
      
   end SchriftpositionFestlegen;
   
   
   
   procedure SchriftartZurücksetzen
   is begin
      
      SchriftartFestgelegt := LeerFestgelegt;
      -- AuflösungBerechnet := (others => LeerFestgelegt);
      
   end SchriftartZurücksetzen;
   
   
   
   procedure TextZurücksetzen
   is begin
      
      TextFestgelegt := LeerFestgelegt;
      -- AuflösungBerechnet := (others => LeerFestgelegt);
      
   end TextZurücksetzen;
   
   
   
   procedure SchriftgrößeZurücksetzen
   is begin
      
      SchriftgrößeFestgelegt := LeerFestgelegt;
      -- AuflösungBerechnet := (others => LeerFestgelegt);
      
   end SchriftgrößeZurücksetzen;

end AnzeigeZusatztextRassenmenueSFML;
